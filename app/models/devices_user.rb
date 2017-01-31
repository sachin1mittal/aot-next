class DevicesUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :device

  enum role: {
    owner: 'owner',
    shared_user: 'shared_user'
  }

  validates_presence_of :role
  has_paper_trail
end
