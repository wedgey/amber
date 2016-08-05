json.extract! weather_log, :id, :lat, :lng, :tmax, :tmin, :precip, :date, :created_at, :updated_at
json.url weather_log_url(weather_log, format: :json)