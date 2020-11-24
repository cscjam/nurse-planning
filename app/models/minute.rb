class Minute < ApplicationRecord
  belongs_to :visit
  has_many_attached :photos
end
