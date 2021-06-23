class VisitCare < ApplicationRecord
  belongs_to :visit
  belongs_to :care

  accepts_nested_attributes_for :care
end
