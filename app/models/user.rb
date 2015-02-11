class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  

  before_validation :reset_session_token!

  def self.find_by_credentials(username, password)
    u = User.find_by(:username => username)
    if u.is_password?(password)
      return u
    end
    nil

  end

  def reset_session_token!
    token = SecureRandom::urlsafe_base64
    self.session_token = token

  end

  def password=(value)
    @password = value
    self.password_digest = BCrypt::Password.create(value)

  end

  def is_password?(value)
    digest = BCrypt::Password.new(self.password_digest)
    digest.is_password?(value)
  end

end
