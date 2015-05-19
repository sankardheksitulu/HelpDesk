class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  attr_accessor :login#, :activation_code, :status

  validates_presence_of :username
  validates :username,
            :uniqueness => {
                :case_sensitive => false
            }
                      #,
                      #:format => { ... } # etc.

  has_one :profile

  def email_required?
    false
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      #where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      where(conditions).where(["lower(username) = lower(:value) OR lower(email) = lower(:value)", { :value => login }]).first
    else
      where(conditions).first
    end
  end

  def self.user_with_phone_number(number)
    puts "user model::::::::::::::::::::::::::::::"
    #User.find_by_username(number)
    if number
      User.where('username LIKE ?','%'+number).first
    else
      nil
    end
  end

#### This is the correct method you override with the code above
#### def self.find_for_database_authentication(warden_conditions)
#### end

end
