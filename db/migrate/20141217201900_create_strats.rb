class CreateStrats < ActiveRecord::Migration
  def change
    create_table :strats do |t|
      t.string :strat_cd
      t.text :strat_description
      t.boolean :protected
      t.integer :ntot
      t.integer :grid_size
      t.integer :year_id
      t.integer :region_id
      t.timestamps
    end
    add_index :strats, :year_id
    add_index :strats, :region_id
  end
end
