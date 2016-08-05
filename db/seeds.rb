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

# 4g/plant is theoretical yield weight
rice = Crop.create(name: "Rice", duration: 100, seed_weight: 0.023, product_plant: 1.3);
rice.stages << Stage.create(name: "Vegetative", start_date: 0, tmax: 31, tmin: 25.2, precip: 30, order: 1)
rice.stages << Stage.create(name: "Reproductive", start_date: 31, tmax: 32, tmin: 25, precip: 20, order: 2)
rice.stages << Stage.create(name: "Maturity", start_date: 65, tmax: 29, tmin: 25, precip: 10, order: 3)

water = Resource.create(name: "Water", price: "0.20")
fertilizer = Resource.create(name: "Fertilizer", price: "0.70")
chemicals = Resource.create(name: "Chemicals", price: "0.50")

water.activities << Activity.create(name: "Water Crops")
fertilizer.activities << Activity.create(name: "Fertilize Farm")
chemicals.activities << Activity.create(name: "Apply Chemicals")

user = User.create(username: 'vanessa', password: 'password')
aiy = User.create(username: 'aiy', password: 'password')
desmond = User.create(username: 'desmond', password: 'password')

user.farms << Farm.create(name: "Vanessa's Farm", size: 50, lat: 4.944, lng: 114.928)
aiy.farms << Farm.create(name: "Aiy's Farm", size: 100, lat: 4.9329689, lng: 114.8100686)
desmond.farms << Farm.create(name: "Farmsville", size: 20, lat: 4.8984209, lng: 114.7649217)
desmond.farms << Farm.create(name: "Second Farm", size: 25, lat: 4.9066305, lng: 114.8270631)

usub = user.farms.first.sub_farms << SubFarm.create(crop_id: 1, size: 50, crop_weight: 100, start_date: Date.new)
asub = aiy.farms.first.sub_farms << SubFarm.create(crop_id: 1, size: 30, crop_weight: 50, start_date: 2.months.ago)
aiy.farms.first.sub_farms << SubFarm.create(crop_id: 1, size: 30, crop_weight: 50, start_date: 1.week.ago)
dsub = desmond.farms.first.sub_farms << SubFarm.create(crop_id: 1, size: 20, crop_weight: 30, start_date: 1.day.ago)
dsub2 = desmond.farms.last.sub_farms << SubFarm.create(crop_id: 1, size: 10, crop_weight: 20, start_date: 1.month.ago)
desmond.farms.first.sub_farms << SubFarm.create(crop_id: 1, size: 15, crop_weight: 50, start_date: 5.days.ago)

usub.first.sub_farm_activities << SubFarmActivity.create(activity_id: 1, amount: 10, date: Date.new, title: "Watered Farm", note: "I way watered too little")
asub.first.sub_farm_activities << SubFarmActivity.create(activity_id: 2, amount: 10, date: Date.new, title: "Fertilized Farm", note: "I fertilized too little")

dsub.first.sub_farm_activities << SubFarmActivity.create(activity_id: 1, amount: 10, date: Date.new, title: "Watered Farm", note: "I watered too little")
dsub2.first.sub_farm_activities << SubFarmActivity.create(activity_id: 3, amount: 10, date: Date.new, title: "Applied Chemicals to Farm", note: "Go away diseases!")