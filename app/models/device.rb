class Device < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail

  belongs_to :network
  has_one :devices_owner, -> { where(role: :owner) }, class_name: 'DevicesUser', dependent: :destroy
  has_one :owner, through: :devices_owner, source: :user
  has_many :devices_users, -> { where(role: :shared_user) }, class_name: 'DevicesUser', dependent: :destroy
  has_many :shared_users, through: :devices_users, source: :user

  enum status: {
    on: 'on',
    off: 'off'
  }

  before_validation :init
  validates_presence_of :serial_number, :name, :status, :slug
  validates_uniqueness_of :slug, :serial_number


  def init
    self.status ||= 'off'
    self.serial_number ||= StringGenerator.device_serial_number
    self.slug ||= StringGenerator.slug_for_device
  end

  def to_param
    slug
  end

  def toggle
    return self.on! if self.off?
    self.off! if self.on?
  end

  def self.find(input)
    input.to_i == 0 ? find_by_slug(input) : super
  end
end
