class CreateParameters < ActiveRecord::Migration
  def change
    create_table :parameters do |t|
      t.float :length_at_capture
      t.float :length_at_maturity
      t.decimal :wlen_a
      t.decimal :wlen_b
      t.integer :animal_id
      t.timestamps
    end
    add_index :parameters, :animal_id
  end
end
