class RecreateWishTimeInVisit < ActiveRecord::Migration[6.0]
  def change
    add_column( :visits, :wish_time, :integer)
  end
end
