class ImportUserCSV < ApplicationRecord
  include CSVImporter

  model Patient #Link with the model to save in

  column :team_id, as: [ "cabinet"], to: ->(name) {Team.find_by(name: name).id}, required: true
  column :first_name, as: [ "prénom" ],  required: true
  column :last_name,  as: [ "nom" ], required: true
  column :phone, as: [ "téléphone"]
  column :address, as: [ "adresse"]
  column :compl_address, as: [ "complement adresse"]

  identifier :first_name, :last_name #will check if patient already exist

  when_invalid :skip #or :abort when invalid entry
end

