class CreatePatients < ActiveRecord::Migration[6.0]
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :compl_address
      t.string :phone
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
