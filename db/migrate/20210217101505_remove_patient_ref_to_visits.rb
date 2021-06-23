class RemovePatientRefToVisits < ActiveRecord::Migration[6.0]
  def change
    remove_reference(:visits, :patient, index: true, foreign_key: true)
  end
end
