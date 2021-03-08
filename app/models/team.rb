class Team < ApplicationRecord
  has_many :users
  has_many :patients

  accepts_nested_attributes_for :patients
  accepts_nested_attributes_for :users
end
