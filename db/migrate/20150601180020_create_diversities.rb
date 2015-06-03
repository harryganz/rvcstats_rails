class CreateDiversities < ActiveRecord::Migration
  def change
    create_table :diversities do |t|
      t.string :primary_sample_unit
      t.string :station_nr
      t.float :richness
      t.integer :strat_id
      t.timestamps
    end
  add_column :samples, :diversity_id, :integer
  end
end
