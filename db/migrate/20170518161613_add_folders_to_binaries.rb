class AddFoldersToBinaries < ActiveRecord::Migration[5.0]
  def change
    add_reference :binaries, :folder, foreign_key: true
  end
end
