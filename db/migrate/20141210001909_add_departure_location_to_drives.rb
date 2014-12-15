class AddDepartureLocationToDrives < ActiveRecord::Migration
  def change
    add_column :drives, :departure_location, :string
  end
end
