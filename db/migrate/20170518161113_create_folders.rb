class CreateFolders < ActiveRecord::Migration[5.0]
  def change
    create_table :folders do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.integer :permission
      t.references :folder, foreign_key: true
      t.string :route

      t.timestamps
    end
  end
end
