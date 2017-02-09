class User < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail

  has_many :devices_users, dependent: :destroy
  has_many :devices, through: :devices_users
  has_many :permissions, through: :roles
  has_and_belongs_to_many :roles
  has_attached_file :photo, styles: { small: "50x50" },
                      path: "/public/:env/:attachment/:id/:style/:updated_at"

  validates_presence_of :name
  validates_attachment :photo, content_type: { content_type: /\Aimage\/.*\Z/ }

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
      user.roles.push(Role.find_by(label: :normal)) unless user.normal?
    end
  end

  def admin?
    roles.admin.present?
  end

  def normal?
    roles.normal.present?
  end

  def permitted?(controller, action)
    permission = Permission.where(controller: controller, action: action).first
    permission.open? || permission_ids.include?(permission.id)
  end
end
