class CreatePsus < ActiveRecord::Migration
  def change
    create_table :psus do |t|
      t.string :psu_cd
      t.integer :month
      t.integer :day
      t.integer :zone_nr
      t.integer :subregion_nr
      t.integer :mapgrid_nr
      t.integer :mpa_nr
      t.integer :strat_id
      t.timestamps
    end
    add_index :psus, :strat_id
  end
end
