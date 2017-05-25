class AddIVtoFolders < ActiveRecord::Migration[5.0]
  def change
    add_column :folders, :iv, :string
  end
end
