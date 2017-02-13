class UserManager

  attr_accessor :user

  def initialize(user)
    self.user = user
  end

  def change_token
    user.update(secret_token: generate_secret_token)
  end

  def generate_secret_token
    Digest::SHA1.hexdigest(user.uid + Time.now.to_s)
  end
end
