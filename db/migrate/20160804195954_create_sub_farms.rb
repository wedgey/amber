class CreateSubFarms < ActiveRecord::Migration[5.0]
  def change
    create_table :sub_farms do |t|
      t.references :farm, foreign_key: true
      t.references :crop, foreign_key: true
      t.float :size
      t.float :crop_weight
      t.datetime :start_date
      t.datetime :harvest_date
      t.string :layout

      t.timestamps
    end
  end
end
