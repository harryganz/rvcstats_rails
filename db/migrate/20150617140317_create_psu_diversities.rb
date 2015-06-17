class CreatePsuDiversities < ActiveRecord::Migration
  def change
    create_table :psu_diversities do |t|
      t.string :primary_sample_unit
      t.integer :strat_diversity_id
      t.integer :richness
      t.timestamps
    end
  end
end
