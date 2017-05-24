class Binary < ApplicationRecord
  validates :name, presence: true
  validates :extension, presence: true
  validates :data_url, presence: true

  belongs_to :folder
  has_many :comments
  has_many :likes, as: :likeable

  def url
    folder.url + '/' + name + '.' + extension
  end
end
