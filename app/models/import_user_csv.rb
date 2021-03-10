class ImportUserCSV < ApplicationRecord
  include CSVImporter

  model Patient #Link with the model to save in

  column :team_id, as: [ /team.?id/i, "cabinet"], required: true
  column :first_name, as: [ /first.?name/i, /pr(é|e)nom/i ], required: true
  column :last_name,  as: [ /last.?name/i, "nom" ] , required: true
  column :address, as: [ /a.?ddress/i, "adresse"], to: ->(adress) {adress.downcase}
  column :phone, as: [ /p.?hone/i, /t(é|e)phone/i]
  column :compl_address, as: [ /compl.?address/i, "complement adresse" ]

  identifier :last_name, :address #will check if patient already exist

  when_invalid :skip #or :abort when invalid entry
end

