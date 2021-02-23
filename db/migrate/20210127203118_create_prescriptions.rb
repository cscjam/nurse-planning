class CreatePrescriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :prescriptions do |t|
      t.string :title
      t.date :start_at
      t.date :end_at
      t.string :schedule

      t.timestamps
    end
  end
end
