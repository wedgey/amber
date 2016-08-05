# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'date'
def seed_weather_logs
  file = File.new("./db/weather_data.csv","r")
  while (line1 = file.gets)
    unless line1.strip == ""

      line = line1.split(',');
      day = Date.new(line[0].to_i, line[1].to_i, line[2].to_i)
      WeatherLog.create(lat: 4.944, lng: 114.928, tmax: line[3].to_f, tmin: line[4], precip: line[5], date: day)
    end
  end
  file.close
end

seed_weather_logs()

rice = Crop.create(name: "Rice", duration: 100)
rice.stages << Stage.create(name: "Vegetative", start_date: 0, tmax: 31, tmin: 25.2, precip: 30, order: 1)
rice.stages << Stage.create(name: "Reproductive", start_date: 31, tmax: 32, tmin: 25, precip: 20, order: 2)
rice.stages << Stage.create(name: "Maturity", start_date: 65, tmax: 29, tmin: 25, precip: 10, order: 3)

water = Resource.create(name: "Water", price: "0.20")
fertilizer = Resource.create(name: "Fertilizer", price: "0.70")
chemicals = Resource.create(name: "Chemicals", price: "0.50")

water.activities << Activity.create(name: "Water Crops")
fertilizer.activities << Activity.create(name: "Fertilize Farm")
chemicals.activities << Activity.create(name: "Apply Chemicals")