class User < ActiveRecord::Base
  has_many :devices_users, dependent: :destroy
  has_many :devices, through: :devices_users
  has_and_belongs_to_many :roles

  validates_presence_of :name, :password
  validates_presence_of :email, unless: :phone_number
  validates_presence_of :phone_number, unless: :email

  acts_as_paranoid
  has_paper_trail
end
