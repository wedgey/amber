class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks do |t|
      t.references :farm, foreign_key: true
      t.references :resource, foreign_key: true
      t.float :amount

      t.timestamps
    end
  end
end
