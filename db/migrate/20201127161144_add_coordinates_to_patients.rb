class AddCoordinatesToPatients < ActiveRecord::Migration[6.0]
  def change
    add_column :patients, :latitude, :float
    add_column :patients, :longitude, :float
  end
end
