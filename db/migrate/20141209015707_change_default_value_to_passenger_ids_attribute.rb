class ChangeDefaultValueToPassengerIdsAttribute < ActiveRecord::Migration
  def change
    change_column :drives, :passenger_ids, :boolean, :default => '0'
  end
end
