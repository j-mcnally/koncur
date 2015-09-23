class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:github]

  def self.from_omniauth(auth)
    puts auth.inspect
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email || "#{Devise.friendly_token[0,20]}@koncur.io"
      user.password = Devise.friendly_token[0,20]
      user.github_username = auth.info.nickname
      user.github_token = auth.credentials.token
      user.name = auth.info.name   # assuming the user model has a name
     end
  end

end
