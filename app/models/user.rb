class User < ActiveRecord::Base
  has_many :devices_users, dependent: :destroy
  has_many :devices, through: :devices_users
  has_and_belongs_to_many :roles

  validates_presence_of :name

  acts_as_paranoid
  has_paper_trail

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
