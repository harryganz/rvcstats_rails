class CreateStrats < ActiveRecord::Migration
  def change
    create_table :strats do |t|
      t.integer :year
      t.string :region
      t.string :strat
      t.integer :prot
      t.integer :ntot
      t.integer :grid_size
      t.timestamps
    end
    add_index :strats, [:year, :region, :strat, :prot], :unique => true #composite index for rapid searhcing of unique strata
  end
end
