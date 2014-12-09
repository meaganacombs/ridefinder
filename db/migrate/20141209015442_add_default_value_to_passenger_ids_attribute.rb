class AddDefaultValueToPassengerIdsAttribute < ActiveRecord::Migration
  def change
    change_column :drives, :passenger_ids, :boolean, :default => true
  end
end
