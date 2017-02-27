class Network < ActiveRecord::Base
  # acts_as_paranoid
  # has_paper_trail

  # belongs_to :user
  # has_many :devices, dependent: :nullify

  # before_validation :init
  # validates_presence_of :name, :password, :slug
  # validates_uniqueness_of :slug

  # def init
  #   self.slug ||= StringGenerator.slug_for_network
  # end

  # def to_param
  #   slug
  # end

  # def self.find(input)
  #   input.to_i == 0 ? find_by_slug(input) : super
  # end
end
