class Folder < ApplicationRecord
  validates :name, presence: true
  validates :route, presence: true

  # validates :route, uniqueness: true
  validates :route, uniqueness: { scope: [:user_id] }

  before_save :slugize

  has_many :shared_folders
  has_many :users_shared_with, through: :shared_folders

  has_many :folders, class_name: 'Folder', foreign_key: 'folder_id'
  belongs_to :parent, class_name: 'Folder', foreign_key: 'folder_id'

  has_many :child_folders

  belongs_to :owner, class_name: "User", foreign_key: "user_id"

  has_many :binaries

  enum permission: %w(personal global)

  before_create :get_user

  def get_user
    user_id = parent.user_id if parent
  end

  def children
    binaries | folders
  end

  def slugize
    self.slug = name.parameterize
  end

  def url
    '/' + owner.username + '/' + route
  end
end
