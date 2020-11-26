class Patient < ApplicationRecord
  belongs_to :team
  has_many :visits

  validates :first_name, presence: true
  validates :last_name, presence: true
end
