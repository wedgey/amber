class AddIndexDateToWeatherLogs < ActiveRecord::Migration[5.0]
  def change
    add_index :weather_logs, :date
  end
end
