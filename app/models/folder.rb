class Folder < ApplicationRecord
  validates :name, presence: true
  validates :route, presence: true

  has_many :shared_folders
  has_many :folders, through: :shared_folders

  belongs_to :owner, class_name: "User", foreign_key: "user_id"
end