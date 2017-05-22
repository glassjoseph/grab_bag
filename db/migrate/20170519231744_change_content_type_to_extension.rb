class ChangeContentTypeToExtension < ActiveRecord::Migration[5.0]
  def change
    rename_column :binaries, :content_type, :extension
  end
end
