class AddDepartureTimeToDrives < ActiveRecord::Migration
  def change
    add_column :drives, :departure_time, :string
  end
end
