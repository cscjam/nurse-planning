class AddColumnsToPrescriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :prescriptions, :lundi, :boolean, default: false
    add_column :prescriptions, :mardi, :boolean, default: false
    add_column :prescriptions, :mercredi, :boolean, default: false
    add_column :prescriptions, :jeudi, :boolean, default: false
    add_column :prescriptions, :vendredi, :boolean, default: false
    add_column :prescriptions, :samedi, :boolean, default: false
    add_column :prescriptions, :dimanche, :boolean, default: false
  end
end
