class User < ApplicationRecord
  has_many :shared_folders
  has_many :folders_shared_with, through: :shared_folders, source: :folder
  has_many :owned_folders, class_name: "Folder", foreign_key: "user_id"

  after_create :make_home

  def home
    owned_folders.find_by(route: 'home')
  end

  def self.from_omniauth(auth)
    new do |user|
      user.fb_id = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.avatar_url = auth["info"]["image"]
      user.token = auth["credentials"]["token"]
    end
  end

private

  def make_home
    owned_folders.create(name: 'home', route: 'home')
  end
end
