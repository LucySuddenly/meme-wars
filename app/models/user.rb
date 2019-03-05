class User < ApplicationRecord
  has_many :posts
  has_many :comments, as: :commentable
  has_many :likes
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "https://i.imgur.com/Lb7Uhwk.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates :username, uniqueness: true
  has_secure_password
end
