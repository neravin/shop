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
  validates :password, length: { minimum: 6, maximum: 50 }

  def generate_password_reset_token!
    update_attribute(:password_reset_token, SecureRandom.urlsafe_base64(48))
  end



  States = {
    :inactive => 0,
    :active => 1,
    :douchebaggish => 2,
  }

  state_machine :state, :initial => :inactive,  :action => :bypass_validation do
    States.each do |name, value|
      state name, :value => value
    end

    event :activate do
      transition all => :active
    end

    event :mark_douchebaggish do
      transition all => :douchebaggish
    end
  end

  def bypass_validation
    if self.changed == ['state']
      save!(:validate => false)
    else
      save!(:validate => true)
    end
  end
  
  private

    def create_remember_token
      self.remember_token = Client.encrypt(Client.new_remember_token)
    
    end
end
