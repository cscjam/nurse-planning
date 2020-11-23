class CreateVisits < ActiveRecord::Migration[6.0]
  def change
    create_table :visits do |t|
      t.date :date
      t.integer :position
      t.time :time
      t.time :wish_time
      t.references :user, null: false, foreign_key: true
      t.references :patient, null: false, foreign_key: true
      t.boolean :is_done

      t.timestamps
    end
  end
end
