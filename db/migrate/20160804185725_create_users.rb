class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :country
      t.string :city
      t.string :phone
      t.string :address
      t.datetime :joined

      t.timestamps
    end
  end
end
