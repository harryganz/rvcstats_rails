class CreateGens < ActiveRecord::Migration
  def change
    create_table :gens do |t|
    	t.string :genus_name
    	t.string :common_name
    	t.integer :family_id
      t.timestamps
    end
    add_index :gens, :family_id
  end
end
