class CreateSharedFolders < ActiveRecord::Migration[5.0]
  def change
    create_table :shared_folders do |t|
      t.references :user, foreign_key: true
      t.references :folder, foreign_key: true

      t.timestamps
    end
  end
end
