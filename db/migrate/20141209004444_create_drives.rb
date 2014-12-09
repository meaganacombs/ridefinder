class CreateDrives < ActiveRecord::Migration
  def change
    create_table :drives do |t|
      t.string :city
      t.integer :num_passengers
      t.integer :driver_id

      t.timestamps
    end
  end
end
