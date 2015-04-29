class AddRugosity < ActiveRecord::Migration
  def change
    add_column :strats, :rfhab, :string
    add_column :strats, :rugosity_cd, :integer
  end
end
