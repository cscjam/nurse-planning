class AddPatientRefToPrescriptions < ActiveRecord::Migration[6.0]
  def change
    add_reference :prescriptions, :patient, null: false, foreign_key: true
  end
end
