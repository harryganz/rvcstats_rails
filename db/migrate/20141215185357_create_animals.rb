## Species-Information
class CreateAnimals < ActiveRecord::Migration
  def change
    create_table :animals do |t|
    	t.string :family_name
      t.string :genus_name
      t.string :species_name
    	t.string :common_name
    	t.string :species_cd
      t.timestamps
    end
  end
end
