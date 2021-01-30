class AddPrescriptionRefToVisits < ActiveRecord::Migration[6.0]
  def change
    add_reference :visits, :prescription, null: false, foreign_key: true
  end
end
