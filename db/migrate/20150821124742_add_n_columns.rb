class AddNColumns < ActiveRecord::Migration
  def change
    add_column :psus, :m, :integer
    add_column :strats, :n, :integer
    add_column :strats, :nm, :integer
  end
end
