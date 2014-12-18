class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.float :num
      t.float :len
      t.integer :time_seen
      t.integer :animal_id
      t.integer :station_id
      t.timestamps
    end
    add_index :records, :animal_id
    add_index :records, :station_id
  end
end
