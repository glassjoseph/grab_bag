class AddSlugToFolders < ActiveRecord::Migration[5.0]
  def change
    add_column :folders, :slug, :string
    add_index :folders, :slug
  end
end
