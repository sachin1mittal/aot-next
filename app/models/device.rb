class Device < ActiveRecord::Base
  has_one :devices_owner, -> { where(role: :owner) }, class_name: 'DevicesUser', dependent: :destroy
  has_one :owner, through: :devices_owner, source: :user

  enum status: {
    on: 'on',
    off: 'off'
  }

  acts_as_paranoid
  has_paper_trail

  before_validation :init
  validates_presence_of :user_provided_name, :password, :token, :current_ip

  def init
    self.status ||= 'off'
  end
end
