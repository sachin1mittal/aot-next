class Role < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :permissions

  validates_presence_of :label
  validates_uniqueness_of :label

  def self.admin
    find_by_label(:Admin)
  end

  def self.normal
    find_by_label(:Normal)
  end
end
