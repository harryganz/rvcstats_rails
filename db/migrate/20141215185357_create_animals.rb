## Species-Information
class CreateAnimals < ActiveRecord::Migration
  def change
    create_table :animals do |t|
    	t.string :species_cd
      t.string :sciname
      t.string :comname
      t.timestamps
    end
    add_index :animals, :species_cd, :unique => true #Index for rapid searching by species code
  end
end
