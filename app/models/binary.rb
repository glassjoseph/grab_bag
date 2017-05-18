class Binary < ApplicationRecord
  validates :name, presence: true
  validates :content_type, presence: true
  validates :data, presence: true

  belongs_to :folder
end