class Post < ApplicationRecord
  # has_attached_file :image, styles: { large: "800x800>", medium: "300x300>", thumb: "100x100>" }
  # validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable
  has_many :reports, as: :reportable
  validates :title, presence: true
  validates_format_of :image_url, :with => %r{\.(png|jpg|jpeg|gif|mp4|mpeg4|gifv)$}i, multiline: true
  validates :image_url, presence: true

  def self.sort_by_new
    Post.all.sort_by do |item|
      item.created_at
    end.reverse
  end

  def self.sort_by_top
     Post.all.sort_by do |item|
       item.likes.count
     end.reverse
  end

  def self.sort_by_dank
    Post.all.sort_by do |item|
     ((Time.now.to_i - item.updated_at.to_i) / 60 / 60).to_f - item.likes.count.to_f 
    end
  end


end
