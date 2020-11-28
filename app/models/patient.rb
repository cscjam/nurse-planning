class Patient < ApplicationRecord
  belongs_to :team
  has_many :visits
  has_many :start_journeys, :class_name => "Journey", :foreign_key => "start_patient_id"
  has_many :end_journeys, :class_name => "Journey", :foreign_key => "end_patient_id"
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  validates :first_name, presence: true
  validates :last_name, presence: true
end
