class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable
end
