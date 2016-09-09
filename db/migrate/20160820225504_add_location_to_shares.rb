class AddLocationToShares < ActiveRecord::Migration
  def change
    add_column :shares, :lat, :string
    add_column :shares, :lon, :string
  end
end
