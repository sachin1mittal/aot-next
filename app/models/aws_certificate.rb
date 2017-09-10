class AwsCertificate < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail

  belongs_to :aws_thing

  validates_presence_of :certificate_id, :arn, :pem, :private_key, :public_key

  before_destroy :delete_aws_entries

  def delete_aws_entries
    # pending
  end
end
