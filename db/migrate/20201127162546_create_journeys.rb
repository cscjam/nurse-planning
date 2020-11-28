class CreateJourneys < ActiveRecord::Migration[6.0]
  def change
    create_table :journeys do |t|
      t.references :start_user_id, foreign_key: { to_table: 'users' }
      t.references :start_patient_id, foreign_key: { to_table: 'patients' }
      t.references :end_user_id, foreign_key: { to_table: 'users' }
      t.references :end_patient_id, foreign_key: { to_table: 'patients' }
      t.integer :locomotion
      t.integer :distance, default: 0
      t.integer :duration, default: 0
      t.boolean :is_done, default: false
      t.timestamps
    end
  end
end
