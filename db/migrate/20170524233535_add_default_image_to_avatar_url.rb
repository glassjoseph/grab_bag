class AddDefaultImageToAvatarUrl < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :avatar_url
    add_column :users, :avatar_url, :string, default: "https://thumb.ibb.co/htakav/default_profile.jpg"
  end
end
