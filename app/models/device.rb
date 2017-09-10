class Device < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail

  # belongs_to :network
  has_one :devices_owner, -> { where(role: :owner) }, class_name: 'DevicesUser', dependent: :destroy
  has_one :owner, through: :devices_owner, source: :user
  has_many :devices_users, -> { where(role: :shared_user) }, class_name: 'DevicesUser', dependent: :destroy
  has_many :shared_users, through: :devices_users, source: :user
  has_one :aws_thing, dependent: :destroy

  enum status: {
    on: 'on',
    off: 'off'
  }

  enum owner_status: {
    active: 'active',
    inactive: 'inactive'
  }

  before_validation :init
  after_create :create_aws_linkage
  validates_presence_of :serial_number, :name, :status, :slug, :owner_status
  validates_uniqueness_of :slug, :serial_number


  def init
    self.status ||= 'off'
    self.owner_status ||= 'active'
    self.serial_number ||= StringGenerator.device_serial_number
    self.slug ||= StringGenerator.slug_for_device
  end

  def to_param
    slug
  end

  def create_aws_linkage
    DeviceManager.new(self).create_aws_linkage
  end

  def toggle
    statuses = self.class.statuses.keys
    current_index = statuses.index(self.status)
    current_index = (current_index + 1) % statuses.count
    self.public_send("#{statuses[current_index]}!")
  end

  def self.find(input)
    input.to_i == 0 ? find_by_slug(input) : super
  end
end
