class DevicesUser < ActiveRecord::Base
  has_paper_trail
  acts_as_paranoid

  belongs_to :user
  belongs_to :device

  enum role: {
    owner: 'owner',
    shared_user: 'shared_user'
  }

  validates_presence_of :role, :user, :device

  before_validation :init
  validates_uniqueness_of :device_id, scope: [:user_id]

  def init
    self.role ||= 'owner'
  end
end
