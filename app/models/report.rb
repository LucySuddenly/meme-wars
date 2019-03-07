class Report < ApplicationRecord
  belongs_to :reportable, polymorphic: true
  validates :content, presence: true
end
