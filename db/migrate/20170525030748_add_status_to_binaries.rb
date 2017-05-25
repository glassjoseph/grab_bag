class AddStatusToBinaries < ActiveRecord::Migration[5.0]
  def change
    add_column :binaries, :status, :integer, default: 0
  end
end
