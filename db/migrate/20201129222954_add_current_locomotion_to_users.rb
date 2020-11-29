class AddCurrentLocomotionToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :current_locomotion, :integer, default: 0
  end
end
