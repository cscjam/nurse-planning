class Prescription < ApplicationRecord
  has_many :visits, dependent: :destroy
  belongs_to :patient
end
