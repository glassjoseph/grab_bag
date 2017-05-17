class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.string :fb_id
      t.integer :status, default: 0
      t.string :email
      t.string :phone
      t.string :token
      t.string :avatar_url

      t.timestamps
    end
  end
end
