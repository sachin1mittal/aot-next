class StringGenerator

  def self.sha_hash(value)
    Digest::SHA1.hexdigest(user.uid + Time.now.to_s)
  end

  def self.slug_for_device
    new_slug = slug
    already_assigned_slugs = Device.pluck(:slug)
    while already_assigned_slugs.include?(new_slug)
      new_slug = slug
    end
    new_slug
  end

  def self.slug_for_user
    new_slug = slug
    already_assigned_slugs = User.pluck(:slug)
    while already_assigned_slugs.include?(new_slug)
      new_slug = slug
    end
    new_slug
  end

  def self.slug_for_network
    new_slug = slug
    already_assigned_slugs = Network.pluck(:slug)
    while already_assigned_slugs.include?(new_slug)
      new_slug = slug
    end
    new_slug
  end

  def self.slug
    r_string = ''
    15.times do
      r_string += (('A'..'Z').to_a + ('a'..'z').to_a).sample
    end
    r_string
  end

  def self.device_serial_number
    serial_no = SecureRandom.hex(6)
    already_assigned_serial_numbers = Device.pluck(:serial_number)
    while already_assigned_serial_numbers.include?(serial_no)
      serial_no = SecureRandom.hex(6)
    end
    serial_no
  end
end
