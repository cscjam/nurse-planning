class RemoveTimeWishInVisit < ActiveRecord::Migration[6.0]
  def change
    remove_column(:visits, :wish_time)
  end
end
