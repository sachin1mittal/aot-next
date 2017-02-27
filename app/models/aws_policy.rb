class AwsPolicy < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail

  belongs_to :aws_thing

  validates_presence_of :name, :arn, :version_id

  before_destroy :delete_aws_entries

  def delete_aws_entries
    # pending
  end
end
