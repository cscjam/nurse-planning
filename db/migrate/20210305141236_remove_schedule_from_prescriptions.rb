class RemoveScheduleFromPrescriptions < ActiveRecord::Migration[6.0]
  def change
    remove_column :prescriptions, :schedule, :string
  end
end
