class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable
  has_attached_file :image, styles: { large: "800x800>", medium: "300x300>", thumb: "100x100>" }, default_url: "https://i.imgur.com/Lb7Uhwk.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/



end
