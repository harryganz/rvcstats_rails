class CreateSamples < ActiveRecord::Migration
  def change 
   create_table :records do |t|
      t.integer :year
      t.integer :month
      t.integer :day
      t.string :region
      t.string :strat
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
      t.string :species_cd
      t.float :num
      t.float :len
      t.integer :animal_id
      t.integer :strat_id
      t.timestamps
    end
    #Index commonly searched
    add_index :records, :year
    add_index :records, :region
    add_index :records, :species_cd
    add_index :records, :strat
    add_index :records, :mpa_nr
    # Index foreign keys
    add_index :records, :animal_id
    add_index :records, :strat_id
  end
end
