class CreateVisitCares < ActiveRecord::Migration[6.0]
  def change
    create_table :visit_cares do |t|
      t.references :visit, null: false, foreign_key: true
      t.references :care, null: false, foreign_key: true

      t.timestamps
    end
  end
end
