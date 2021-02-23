class AddColumnToPrescriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :prescriptions, :wish_time, :integer
  end
end
