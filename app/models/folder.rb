class Folder < ApplicationRecord
  validates :name, presence: true
  validates :route, presence: true

  validates :slug, presence: true, uniqueness: true


  has_many :shared_folders
  has_many :users_shared_with, through: :shared_folders

  has_many :folders, class_name: 'Folder', foreign_key: 'folder_id'
  belongs_to :parent, class_name: 'Folder', foreign_key: 'folder_id'

  has_many :child_folders

  belongs_to :owner, class_name: "User", foreign_key: "user_id"

  has_many :binaries

  enum permission: %w(personal global)

  def children
    binaries | folders
  end

  def slug
    name.parameterize
  end

  def url
    '/' + owner.username + '/' + route
  end
end
