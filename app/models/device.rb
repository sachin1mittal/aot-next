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
  validates_presence_of :user_provided_name, :password, :token, :api
  validates_length_of :user_provided_name, maximum: 20
  validates_format_of :password, with: /\A[A-Za-z0-9]+\Z/, message: 'can only contain AlphaNumeric Characters'

  def init
    self.status ||= 'off'
  end

  def toggle
    return self.on! if self.off?
    self.off! if self.on?
  end
end
