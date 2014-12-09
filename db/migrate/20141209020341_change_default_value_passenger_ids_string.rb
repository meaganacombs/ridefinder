class ChangeDefaultValuePassengerIdsString < ActiveRecord::Migration
  def change
    change_column :drives, :passenger_ids, :string, :default => '0'
  end
end
