require 'bcrypt'

class User < ApplicationRecord

  has_one_attached :profile
  
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
  validates :name, :length => { :in => 4..30}

  validates_presence_of :email
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates_uniqueness_of :email, :case_sensitive => false

  has_secure_password
  validates :password, :length => { :in => 6..30}

  validates_presence_of :profile

  before_create { generate_token(:remember_token)}

  def generate_token(column)

    begin 

      self[column] = SecureRandom.urlsafe_base64

    end while User.exists?(column => self[column])
    
  end
  
end