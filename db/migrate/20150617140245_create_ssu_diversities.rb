class CreateSsuDiversities < ActiveRecord::Migration
  def change
    create_table :ssu_diversities do |t|
      t.integer :psu_diversity_id
      t.integer :station_nr
      t.integer :richness
      t.timestamps
    end
  end
end
