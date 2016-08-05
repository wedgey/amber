class AddSeedWeightToCrops < ActiveRecord::Migration[5.0]
  def change
    add_column :crops, :seed_weight, :decimal
    add_column :crops, :product_plant, :decimal
    add_column :sub_farms, :active, :boolean, default: true
    add_column :sub_farms, :yield, :float
  end
end
