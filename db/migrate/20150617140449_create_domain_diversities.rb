class CreateDomainDiversities < ActiveRecord::Migration
  def change
    create_table :domain_diversities do |t|
      t.string :region
      t.integer :year
      t.integer :richness
      t.timestamps
    end
  end
end
