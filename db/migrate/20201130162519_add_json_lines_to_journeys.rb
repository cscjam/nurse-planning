class AddJsonLinesToJourneys < ActiveRecord::Migration[6.0]
  def change
    add_column :journeys, :lines_json, :text, default: ""
  end
end
