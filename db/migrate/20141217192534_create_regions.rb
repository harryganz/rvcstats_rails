class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :region_cd
      t.string :region_name
      t.integer :region_nr
      t.timestamps
    end
  end
end
