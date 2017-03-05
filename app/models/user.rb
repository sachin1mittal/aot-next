class User < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail

  has_many :devices_users, -> { where(role: :shared_user) }, class_name: 'DevicesUser', dependent: :destroy
  has_many :shared_devices, through: :devices_users, source: :device
  has_many :devices_owners, -> { where(role: :owner) }, class_name: 'DevicesUser', dependent: :destroy
  has_many :owned_devices, through: :devices_owners, source: :device

  has_many :permissions, through: :roles
  # has_many :networks, dependent: :destroy
  has_and_belongs_to_many :roles
  has_attached_file :photo, styles: { small: "50x50", medium: "200x200"},
                      path: "/public/:env/:attachment/:id/:style/:updated_at"

  validates_presence_of :name, :slug, :email, :uid
  validates_uniqueness_of :slug, :email, :uid
  validates_attachment :photo, content_type: { content_type: /\Aimage\/.*\Z/ }

  before_validation :init

  def init
    self.slug ||= StringGenerator.slug_for_user
  end

  def to_param
    slug
  end

  def shared_users
    user_ids = owned_devices.map { |device| device.shared_user_ids }.flatten
    self.class.where(id: user_ids)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.photo = open(auth.info.image)
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
      user.roles.push(Role.normal) unless user.normal?
    end
  end

  def devices
    Device.where(id: device_ids)
  end

  def device_ids
    (shared_device_ids + owned_device_ids).uniq
  end

  def admin?
    roles.admin.present?
  end

  def normal?
    roles.normal.present?
  end

  def permitted?(controller, action)
    permission = Permission.where(controller: controller, action: action).first
    permission.open? || permission_ids.include?(permission.id) if permission
  end

  def self.find(input)
    input.to_i == 0 ? find_by_slug(input) : super
  end
end
