class DeviceManager

  attr_accessor :device

  def initialize(device)
    self.device = device
  end

  def generate_credentails_file
    FileUtils.rm_rf(File.join(Rails.root, 'public', 'temp_device_credentials', 'certs'))
    Dir.mkdir(File.join(Rails.root, 'public', 'temp_device_credentials', 'certs'), 0777)
    @certificate = device.aws_thing.aws_certificate
    generate_private_key
    generate_public_key
    generate_certificate
    copy_root_certificate
    create_zip_file
  end

  def generate_private_key
    private_key = File.new(
                    File.join(
                      Rails.root,
                      'public',
                      'temp_device_credentials',
                      'certs',
                      'private.pem.key'
                    ),
                    'w+'
                  )
    private_key.puts(@certificate.private_key)
    private_key.close
  end

  def generate_public_key
    public_key = File.new(
                    File.join(
                      Rails.root,
                      'public',
                      'temp_device_credentials',
                      'certs',
                      'public.pem.key'
                    ),
                    'w+'
                  )
    public_key.puts(@certificate.public_key)
    public_key.close
  end

  def generate_certificate
    certificate = File.new(
                    File.join(
                      Rails.root,
                      'public',
                      'temp_device_credentials',
                      'certs',
                      'certificate.pem.crt'
                    ),
                    'w+'
                  )
    certificate.puts(@certificate.pem)
    certificate.close
  end

  def copy_root_certificate
    src = File.join(Rails.root, 'app', 'views', 'templates', 'root-CA.crt')
    dst = File.join(Rails.root, 'public', 'temp_device_credentials', 'certs', 'root-CA.crt')
    FileUtils.cp(src, dst)
  end

  def create_zip_file
    path = Rails.root.to_s + '/public/temp_device_credentials/certs'
    archive = Rails.root.to_s + '/public/temp_device_credentials/certs.zip'
    `rm "#{archive}"`
    `zip -rj "#{archive}" "#{path}"`
  end

  def create_aws_linkage
    @iot_handler = Aws::IoT::Client.new()
    create_aws_thing
    create_aws_policy
    create_aws_certificate
  end

  def create_aws_thing
    thing = @iot_handler.create_thing(thing_name: device.serial_number)
    device.create_aws_thing(name: thing.thing_name, arn: thing.thing_arn)
    device_handler.update_thing_shadow({ thing_name: device.serial_number,
      payload: '{"state": {"desired": {"status": "off"}, "reported": {"status": "off"}}}' })
  end

  def create_aws_policy
    file = File.join(Rails.root, 'app', 'views', 'templates', 'aws_policy_document.text.erb')
    policy = @iot_handler.create_policy(
      policy_name: device.serial_number,
      policy_document: ERB.new(File.read(file)).result(binding)
    )
    device.aws_thing.create_aws_policy(
      name: policy.policy_name,
      version_id: policy.policy_version_id,
      arn: policy.policy_arn
    )
  end

  def create_aws_certificate
    certificate = @iot_handler.create_keys_and_certificate
    @iot_handler.update_certificate(certificate_id: certificate.certificate_id, new_status: :ACTIVE)
    @iot_handler.attach_thing_principal(thing_name: device.serial_number, principal: certificate.certificate_arn)
    @iot_handler.attach_principal_policy(policy_name: device.serial_number, principal: certificate.certificate_arn)
    device.aws_thing.create_aws_certificate(
      certificate_id: certificate.certificate_id,
      arn: certificate.certificate_arn,
      pem: certificate.certificate_pem,
      private_key: certificate.key_pair.private_key,
      public_key: certificate.key_pair.public_key
    )
  end

  def add_user(user)
    device.shared_users.push(user)
  end

  def remove_user(user)
    if device.owner.id == user.id
      device.devices_users.destroy_all
      device.devices_owner.destroy
    else
      device.shared_users.destroy(user)
    end
  end

  def toggle
    device_handler.get_thing_shadow({ thing_name: device.aws_thing.name })
    device.toggle
    device_handler.publish({ topic: device.aws_thing.name, qos: 1, payload: device.status })
  end

  def device_handler
    @device_handler ||= Aws::IoTDataPlane::Client.new(
                                            endpoint: ENV['AWS_ENDPOINT'],
                                            region: ENV['AWS_REGION'],
                                            logger: Rails.logger)
  end

end
