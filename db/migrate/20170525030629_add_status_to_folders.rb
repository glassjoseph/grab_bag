class AddStatusToFolders < ActiveRecord::Migration[5.0]
  def change
    add_column :folders, :status, :integer,  default: 0
  end
end
