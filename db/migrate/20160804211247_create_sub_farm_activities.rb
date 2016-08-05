class CreateSubFarmActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :sub_farm_activities do |t|
      t.references :sub_farm, foreign_key: true
      t.references :activity, foreign_key: true
      t.float :amount
      t.datetime :date
      t.string :title
      t.text :note

      t.timestamps
    end
  end
end
