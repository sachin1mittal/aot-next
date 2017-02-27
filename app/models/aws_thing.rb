class AwsThing < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail

  belongs_to :device
  has_one :aws_certificate, dependent: :destroy
  has_one :aws_policy, dependent: :destroy

  validates_presence_of :name, :arn

  before_destroy :delete_aws_entries

  def delete_aws_entries
    # pending
  end
end
