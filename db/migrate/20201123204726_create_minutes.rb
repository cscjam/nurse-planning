class CreateMinutes < ActiveRecord::Migration[6.0]
  def change
    create_table :minutes do |t|
      t.text :content
      t.references :visit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
