class User < ActiveRecord::Base
  has_one_time_password column_name: :otp_secret_key, length: 4
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  devise :omniauthable, :omniauth_providers => [:google_oauth2]
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first
    # Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.new(
           email: data["email"],
           firstname: data["first_name"],
           lastname: data["last_name"],
           picture: data["image"],
           password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation!
        user.save
    end
    user
  end

end
