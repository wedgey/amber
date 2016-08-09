class AddXywhToSubFarms < ActiveRecord::Migration[5.0]
  def change
    add_column :sub_farms, :x, :float
    add_column :sub_farms, :y, :float
    add_column :sub_farms, :width, :float
    add_column :sub_farms, :height, :float
  end
end
