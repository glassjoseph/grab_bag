class AlterBinariesData < ActiveRecord::Migration[5.0]
  def change
    remove_column :binaries, :data
    add_column :binaries, :data_url, :string
  end
end
