class Minute < ApplicationRecord
  belongs_to :visit
  has_many_attached :photos
  validates :content, presence: { message: "A compte-rendu, nécessite un commentaire ou des photos." }, unless: :has_photos?

  def has_photos?
    photos.count > 0
  end
end
