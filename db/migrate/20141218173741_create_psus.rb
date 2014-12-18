class CreatePsus < ActiveRecord::Migration
  def change
    create_table :psus do |t|

      t.timestamps
    end
  end
end
