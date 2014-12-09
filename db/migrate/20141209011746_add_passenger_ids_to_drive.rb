class AddPassengerIdsToDrive < ActiveRecord::Migration
  def change
    add_column :drives, :passenger_ids, :string
  end
end
