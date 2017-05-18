class User < ApplicationRecord
  validates :username, presence: true
  validates :name, presence: true
  validates :status, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates_uniqueness_of :username, case_sensitive: false

  enum status: %w(active inactive)

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
