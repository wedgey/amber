class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.string :name
      t.references :resource, foreign_key: true

      t.timestamps
    end
  end
end
