class User < ActiveRecord::Base

	has_many :stickers, through: :duplicate_stickers
	has_many :favorites
	has_many :friends, through: :favorites

	def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
  
  def is_favorite_of(user)
  	user.favorites.where(favorite: self).exists?
  end
  
end
