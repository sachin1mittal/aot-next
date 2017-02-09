class Role < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :permissions

  validates_presence_of :label
  validates_uniqueness_of :label
  scope :admin, -> { where(label: :admin) }
  scope :normal, -> { where(label: :normal) }
end
