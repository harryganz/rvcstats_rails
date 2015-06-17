class CreateStratDiversities < ActiveRecord::Migration
  def change
    create_table :strat_diversities do |t|
      t.integer :strat_id
      t.integer :domain_diversity_id
      t.integer :richness
      t.timestamps
    end
  end
end
