class CreateCares < ActiveRecord::Migration[6.0]
  def change
    create_table :cares do |t|
      t.string :name
      t.integer :duration
      t.string :icon

      t.timestamps
    end
  end
end
