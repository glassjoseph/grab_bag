class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :binary
  has_many :likes, as: :likeable
end
