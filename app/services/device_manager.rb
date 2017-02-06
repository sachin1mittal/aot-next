class DeviceManager

  def initialize(device)
    self.device = device
  end

  def toggle(state)
    true
  end

  private

  attr_accessor :device
end
