class CreateStages < ActiveRecord::Migration[5.0]
  def change
    create_table :stages do |t|
      t.string :name
      t.integer :start_date
      t.references :crop, foreign_key: true
      t.decimal :tmax
      t.decimal :tmin
      t.float :precip
      t.integer :order

      t.timestamps
    end
  end
end
