class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.boolean :like
      t.references :likeable, polymorphic: true
      t.timestamps
    end
  end
end
