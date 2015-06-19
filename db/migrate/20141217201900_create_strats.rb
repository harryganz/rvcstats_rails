class CreateStrats < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.integer :year
      t.string :region
      t.integer :richness
      t.timestamps
    end
    create_table :strats do |t|
      t.string :strat
      t.integer :prot
      t.integer :ntot
      t.integer :grid_size
      t.integer :richness
      t.integer :domain_id
      t.timestamps
    end
    add_index :strats, :domain_id
  end
end
