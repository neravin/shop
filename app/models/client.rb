class Client < ActiveRecord::Base
  before_save {self.email = email.downcase }
  before_create :create_remember_token

  def Client.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Client.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6 }

  
  private

    def create_remember_token
      self.remember_token = Client.encrypt(Client.new_remember_token)
    end
end
