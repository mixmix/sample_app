# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation#, :admin#note :admin excluded so can't be mass-assigned
  has_secure_password
  has_many :microposts, dependent: :destroy
# before_save { |user| user.email = email.downcase }
  before_save { self.email.downcase! }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
# VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z]+[\.a-z]*\.[a-z]{2,}+\z/i  #must: have @letter(s) [can have .letters] . letter (>=2) 
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 6 } # ,presence: true #removed because password_digest and password missing are same?
  validates :password_confirmation, presence: true


  def feed               #? why does this go in the model? how is this used when chained like current_user.feed ? 
    #? why would   microposts work insread of Micropost.where(..) ?  why isn't it self.microposts ? 
    # This is preliminary. See "Following users" for the full implementation.
    Micropost.where("user_id = ?", id)   #the '?'  ensure the id is properly 'escaped', protects againsts SQL injection
  end


    def can_be_deleted_by?(guy_trying)
      (self != guy_trying) && guy_trying.admin
    end

  private
    
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
    
end
