class EditFoldersPermission < ActiveRecord::Migration[5.0]
  def change
    remove_column :folders, :permission
    add_column :folders, :permission, :integer, default: 0
  end
end
