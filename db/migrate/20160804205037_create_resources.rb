class CreateResources < ActiveRecord::Migration[5.0]
  def change
    create_table :resources do |t|
      t.string :name
      t.decimal :price

      t.timestamps
    end
  end
end
