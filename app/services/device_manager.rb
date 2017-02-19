class DeviceManager

  attr_accessor :device, :response

  def initialize(device)
    self.device = device
  end

  def get_microcontroller_script
    @user = device.owner
    file = File.join(Rails.root, 'app', 'views', 'templates', 'device_script.text.erb')
    ERB.new(File.read(file)).result(binding)
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
    device.toggle
  end

end
