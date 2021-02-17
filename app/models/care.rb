class Care < ApplicationRecord
  has_many :visit_cares
  has_many :visits, through: :visit_cares
  validates :name, presence: true, uniqueness: true
  validates :duration, numericality: { only_integer: true, greater_or_equal_than: 0 }
  validates :icon, presence: true, uniqueness: true
end
