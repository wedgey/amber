class CreateFarms < ActiveRecord::Migration[5.0]
  def change
    create_table :farms do |t|
      t.references :user
      t.string :name
      t.string :farm_code
      t.decimal :lat
      t.decimal :lng
      t.string :layout
      t.decimal :size

      t.timestamps
    end
  end
end
