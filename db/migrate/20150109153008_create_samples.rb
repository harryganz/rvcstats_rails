class CreateSamples < ActiveRecord::Migration
  def change 
   create_table :samples do |t|
      t.integer :month
      t.integer :day
      t.string :primary_sample_unit
      t.integer :zone_nr
      t.integer :subregion_nr
      t.integer :mapgrid_nr
      t.integer :mpa_nr
      t.integer :time_seen
      t.integer :station_nr
      t.float :lat_degrees
      t.float :lon_degrees
      t.float :depth
      t.float :underwater_visibility
      t.string :habitat_cd
      t.float :num
      t.float :len
      t.integer :animal_id
      t.integer :strat_id
      t.timestamps
    end
    # Index foreign keys
    add_index :samples, :animal_id
    add_index :samples, :strat_id
  end
end
