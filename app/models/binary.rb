class Binary < ApplicationRecord
  validates :name, presence: true
  validates :content_type, presence: true
  validates :data, presence: true

  belongs_to :folder

  def uploaded_file=(incoming_file)
    self.name = incoming_file.original_filename
    self.content_type = incoming_file.content_type
    self.data = incoming_file.read
  end

  def name=(new_filename)
    write_attribute("name", sanitize_filename(new_filename))
  end

  private
    def sanitize_filename(filename)
      just_filename = File.basename(filename)
      just_filename.gsub(/[^\w\.\-]/, '_')
    end
end
