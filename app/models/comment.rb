class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable
  has_many :reports, as: :reportable
  belongs_to :user
  validates :content, presence: true
end
