class User < ApplicationRecord
  after_initialize :ensure_session_token
  def ensure_session_token
    self.session_token ||= self.reset_session_token!
  end
  
  def self.generate_session_token
    SecureRandon::urlsafe_base64
  end
  
  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
  end
  
  attr_reader :password
  
  def password=(password)
    password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
     BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return nil unless user
    user.is_password?(password) ? user : nil
  end
end
