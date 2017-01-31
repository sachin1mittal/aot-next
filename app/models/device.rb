class Device < ActiveRecord::Base
  has_many :devices_users, dependent: :destroy
  has_many :users, through: :devices_users

  enum selling_status: {
    brand_new: 'brand_new',
    active: 'active',
    inactive: 'inactive',
    defective: 'defective'
  }

  enum working_status: {
    on: 'on',
    off: 'off'
  }

  enum usage_type: {
    personal: 'personal',
    shareable: 'shareable'
  }

  acts_as_paranoid
  has_paper_trail
end
