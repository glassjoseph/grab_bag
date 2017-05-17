class User < ApplicationRecord
  def self.from_omniauth(auth)
    new do |user|
      user.fb_id = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.avatar_url = auth["info"]["image"]
      user.token = auth["credentials"]["token"]
    end
  end
end
