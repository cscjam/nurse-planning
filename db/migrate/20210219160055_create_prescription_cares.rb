class CreatePrescriptionCares < ActiveRecord::Migration[6.0]
  def change
    create_table :prescription_cares do |t|
      t.references :prescription, null: false, foreign_key: true
      t.references :care, null: false, foreign_key: true

      t.timestamps
    end
  end
end
