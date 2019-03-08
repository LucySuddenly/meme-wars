class Post < ApplicationRecord
  # has_attached_file :image, styles: { large: "800x800>", medium: "300x300>", thumb: "100x100>" }
  # validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable
  has_many :reports, as: :reportable
  validates :title, presence: true
  validates_format_of :image_url, :with => %r{\.(png|jpg|jpeg)$}i, multiline: true
  validates :image_url, presence: true



end
