class CreateSamples < ActiveRecord::Migration
  def change
   create_table :psus do |t|
     t.integer :month
     t.integer :day
     t.string :primary_sample_unit
     t.integer :zone_nr
     t.integer :subregion_nr
     t.integer :mapgrid_nr
     t.integer :mpa_nr
     t.integer :richness
     t.integer :strat_id
     t.timestamps
   end
   create_table :ssus do |t|
     t.integer :station_nr
     t.float :lat_degrees
     t.float :lon_degrees
     t.float :depth
     t.float :underwater_visibility
     t.string :habitat_cd
     t.integer :richness
     t.integer :psu_id
     t.timestamps
   end
   create_table :samples do |t|
      t.integer :time_seen
      t.float :num
      t.float :len
      t.integer :animal_id
      t.integer :ssu_id
      t.timestamps
    end
    # Index foreign keys
    add_index :samples, :animal_id
    add_index :samples, :ssu_id
    add_index :ssus, :psu_id
    add_index :psus, :strat_id
  end
end
