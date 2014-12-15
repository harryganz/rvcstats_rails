## Species-Information
class CreateAnimals < ActiveRecord::Migration
  def change
    create_table :animals do |t|
    	t.string :species_name
    	t.string :common_name
    	t.string :species_cd
    	t.integer :species_nr
    	# Foreign Keys
    	t.integer :gen_id #Genus

      t.timestamps
    end
    # Index foreign keys
    add_index :animals, :gen_id
  end
end
