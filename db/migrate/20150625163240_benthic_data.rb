class BenthicData < ActiveRecord::Migration
  def change
    add_column :ssus, :max_hard_relief, "float"
    add_column :ssus, :max_soft_relief, "float"
    add_column :ssus, :avg_hard_relief, "float"
    add_column :ssus, :hard_rel_pct_0, "float"
    add_column :ssus, :hard_rel_pct_1, "float"
    add_column :ssus, :hard_rel_pct_2, "float"
    add_column :ssus, :hard_rel_pct_3, "float"
    add_column :ssus, :hard_rel_pct_4, "float"
    add_column :ssus, :pct_sand, "float"
    add_column :ssus, :pct_hard_bottom, "float"
    add_column :ssus, :pct_coral, "float"
    add_column :ssus, :pct_octo, "float"
    add_column :ssus, :pct_sponge, "float"
  end
end
