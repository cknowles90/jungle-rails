class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  # validates :password, presence: true, confirmation: true, length: { minimum: 8 }

  def self.authenticate_with_credentials(email, password)
    return nil if email.nil? || password.nil?

    Rails.logger.debug "Authenticating user with email: #{email}"
    
    user = User.find_by_email(email.strip.downcase)
    Rails.logger.debug "User found by email: #{user.inspect}"
    
    if user && user.authenticate(password)
      Rails.logger.debug "Authenitcation successful!"
      return user
    else
      Rails.logger.debug "Authentication failed."
      return nil
    end
  end
  
  attr_accessor :name
end
