class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.integer :station_nr
      t.float :lat_degrees
      t.float :lon_degrees
      t.float :depth
      t.float :underwater_visibility
      t.string :habitat_cd
      t.float :radius, :null => false
      t.integer :psu_id
      t.timestamps
    end
    add_index :stations, :psu_id
  end
end
