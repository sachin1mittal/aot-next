class Permission < ActiveRecord::Base
  has_and_belongs_to_many :roles

  enum status: {
    active: 'active',
    inactive: 'inactive'
  }

  enum category: {
    open: 'open',
    login: 'login'
  }

  validates_presence_of :controller, :action, :status, :category
  validates_uniqueness_of :action, scope: :controller

  before_validation :init

  def init
    self.status ||= 'active'
    self.category ||= 'login'
  end
end
