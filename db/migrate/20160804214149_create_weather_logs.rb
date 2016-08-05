class CreateWeatherLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :weather_logs do |t|
      t.decimal :lat
      t.decimal :lng
      t.decimal :tmax
      t.decimal :tmin
      t.float :precip
      t.datetime :date

      t.timestamps
    end
  end
end
