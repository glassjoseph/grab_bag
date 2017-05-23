class Binary < ApplicationRecord
  validates :name, presence: true
  validates :extension, presence: true
  validates :data_url, presence: true

  belongs_to :folder
  has_many :comments

  def url
    folder.url + '/' + name + '.' + extension
  end

#   I believe this will be unnecessary for an S3 implementation
#
#   def uploaded_file=(incoming_file)
#     self.name = incoming_file.original_filename
#     self.extension = incoming_file.extension
#     self.data = incoming_file.read
#   end

#   def name=(new_filename)
#     write_attribute("name", sanitize_filename(new_filename))
#   end
# private

#   def sanitize_filename(filename)
#     just_filename = File.basename(filename)
#     just_filename.gsub(/[^\w\.\-]/, '_')
#   end
end
