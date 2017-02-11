class DeviceManager

  attr_accessor :device, :response

  def initialize(device)
    self.device = device
  end

  # def toggle(state)
  #   if device.id.odd?
  #     { success: false, message: 'Device Not Responding' }
  #   else
  #     { success: true }
  #   end
  # end

  def toggle(state)
    begin
      device.send("#{state}!")
      toggle_physical_device(state)
      response
    rescue StandardError => e
      device.toggle if device.send("#{state}?")
      { success: false, message: e.message }
    end
  end

  def toggle_physical_device(state)
    self.response = RestClient.post(device.api, { token: device.token, password: device.password })
    self.response = JSON.parse(self.response)
                        .select do |key, value|
                          [:success, 'success', 'message', :message].include?(key)
                        end
    self.response['success'] = to_boolean(self.response['success'])
    self.response['message'] ||= 'Device Not Responding'
    device.toggle if !response['success']
  end

  def to_boolean(value)
    if value == 'true'
      true
    elsif value == 'false'
      false
    end
  end

end
