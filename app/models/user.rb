class User < ApplicationRecord
  # has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "https://i.imgur.com/Lb7Uhwk.png"
  # validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  has_many :posts
  has_many :comments
  has_many :reports, as: :reportable
  has_many :likes
  validates :username, {uniqueness: true, presence: true}
  validates :display_name, presence: true
  has_secure_password

  def number_of_likes
    counter = 0
    self.posts.each do |p|
      counter += p.likes.count
    end
    counter
  end


end
