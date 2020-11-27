class Patient < ApplicationRecord
  belongs_to :team
  has_many :visits
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  validates :first_name, presence: true
  validates :last_name, presence: true
end
