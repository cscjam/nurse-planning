class Patient < ApplicationRecord
  belongs_to :team
  has_many :visits
end
