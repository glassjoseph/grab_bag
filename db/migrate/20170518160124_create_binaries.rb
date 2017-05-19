class CreateBinaries < ActiveRecord::Migration[5.0]
  def change
    create_table :binaries do |t|
      t.string :name
      t.string :content_type
      t.binary :data

      t.timestamps null: false
    end
  end
end
