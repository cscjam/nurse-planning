class AddPrescriptionRefToVisits < ActiveRecord::Migration[6.0]
  def change
    add_reference :visits, :prescription, foreign_key: true
  end
end
