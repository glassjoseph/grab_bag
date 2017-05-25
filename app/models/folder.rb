class Folder < ApplicationRecord
  validates :name, presence: true
  validates :route, presence: true
  validates :route, uniqueness: { scope: [:user_id] }

  before_validation :get_slug
  before_validation :get_user
  before_validation :get_route

  has_many :binaries, dependent: :destroy
  has_many :child_folders
  has_many :shared_folders
  has_many :users_shared_with, through: :shared_folders
  has_many :folders, class_name: 'Folder', foreign_key: 'folder_id', dependent: :destroy
  belongs_to :parent, class_name: 'Folder', foreign_key: 'folder_id'
  belongs_to :owner, class_name: "User", foreign_key: "user_id"

  enum permission: %w(personal global root_global)

  def children
    binaries | folders
  end

  def encrypted_route
    owner.username + '/' + encrypt + '/' + slug
  end

  def url
    '/' + owner.username + '/' + route
  end

  def encrypt
    cipher = OpenSSL::Cipher::Cipher.new('DES-EDE3-CBC').encrypt
    cipher.key = Digest::SHA1.hexdigest ENV['encrypt_key']
    s = cipher.update(route) + cipher.final
    s.ljust(30).unpack('H*')[0].upcase
  end

  def self.decrypt(string)
    cipher = OpenSSL::Cipher::Cipher.new('DES-EDE3-CBC').decrypt
    cipher.key = Digest::SHA1.hexdigest ENV['encrypt_key']
    s = [string].pack("H*").unpack("C*").pack("c*")

    cipher.update(s.rstrip) + cipher.final
  end

  private

  def get_user
    self.user_id = parent.user_id if parent
  end

  def get_slug
    self.slug = name.parameterize if name
  end

  def get_route
    self.route = "#{parent.route}/#{slug}" if parent
  end
end
