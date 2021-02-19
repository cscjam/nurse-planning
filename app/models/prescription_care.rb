class PrescriptionCare < ApplicationRecord
  belongs_to :prescription
  belongs_to :care
end
