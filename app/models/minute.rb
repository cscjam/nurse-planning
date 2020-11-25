class Minute < ApplicationRecord
  belongs_to :visit
  has_many_attached :photos
  # validates :content, presence: true
end
