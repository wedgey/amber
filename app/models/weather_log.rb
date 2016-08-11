class WeatherLog < ApplicationRecord
  scope :get_duration, -> (start_date, end_date) { where("date >= ? AND date <= ?", start_date, end_date) }

  class << self

    # Forecasts weather for the next 100 days
    # Inputs lat:float (Latitude of city we want to forecast for), lng:float (Longitude of same city)
    # Outputs Object with avg history for each crop stage, the current avgs, and the forecasts for each stage along with the diffs used
    def forecast(lat,lng)
      current = open("http://api.wunderground.com/api/#{Rails.application.secrets.wunderground_api_key}/forecast10day/q/#{lat.to_f},#{lng.to_f}.json");
      # current = open("http://api.wunderground.com/api/#{Rails.application.secrets.wunderground_api_key}/forecast10day/q/#{lat},#{lng}.json");
      forecast = JSON.parse(current.read)['forecast']['simpleforecast']['forecastday']
      fore_ttl_tmax = 0
      fore_ttl_tmin = 0
      fore_ttl_precip = 0
      forecast.each do |val|
        fore_ttl_tmax += val['high']['fahrenheit'].to_i
        fore_ttl_tmin += val['low']['fahrenheit'].to_i
      end
      fore_avg_tmax = fore_ttl_tmax / forecast.size
      fore_avg_tmin = fore_ttl_tmin / forecast.size

      current_past = 1.year.ago
      comparator = calc_avg(get_duration(current_past, 10.days.since(current_past)))

      tmax_diff = fore_avg_tmax / comparator[:avg_tmax]
      tmin_diff = fore_avg_tmin / comparator[:avg_tmin]

      # p "Tmax diff: #{tmax_diff.to_f} (over 1 means currently warmer)"
      # p "Tmin diff: #{tmin_diff.to_f}"

      # p "Tmax diff: #{(comparator[:avg_tmax] / fore_avg_tmax).to_f} (over 1 means currently colder)"
      # p "Tmin diff: #{(comparator[:avg_tmin] / fore_avg_tmin).to_f}"
      first_avgs = calc_avg(get_duration(current_past, 30.days.since(current_past)))
      second_avgs = calc_avg(get_duration(31.days.since(current_past), 64.days.since(current_past)))
      third_avgs = calc_avg(get_duration(65.days.since(current_past), 100.days.since(current_past)))

      {
        history: {
          first: {
            avg_tmax: first_avgs[:avg_tmax],
            avg_tmin: first_avgs[:avg_tmin]
          },
          second: {
            avg_tmax: second_avgs[:avg_tmax],
            avg_tmin: second_avgs[:avg_tmin]
          },
          third: {
            avg_tmax: third_avgs[:avg_tmax],
            avg_tmin: third_avgs[:avg_tmin]
          }
        },
        current: {
          avg_tmax: fore_avg_tmax,
          avg_tmin: fore_avg_tmin
        },
        forecasts: {
          diff: {
            tmax: tmax_diff,
            tmin: tmin_diff
          },
          avgs: {
            first: {
              avg_tmax: (first_avgs[:avg_tmax] * tmax_diff).to_f,
              avg_tmin: (first_avgs[:avg_tmin] * tmin_diff).to_f
            },
            second: {
              avg_tmax: (second_avgs[:avg_tmax] * tmax_diff).to_f,
              avg_tmin: (second_avgs[:avg_tmin] * tmin_diff).to_f
            },
            third: {
              avg_tmax: (third_avgs[:avg_tmax] * tmax_diff).to_f,
              avg_tmin: (third_avgs[:avg_tmin] * tmin_diff).to_f
            }
          },
        }
      } 

    end
  end

  private

  class << self
    def calc_avg(weathers)
      avg_tmax = 0
      avg_tmin = 0
      avg_precip = 0
      weathers.each do |val|
        avg_tmax += val[:tmax]
        avg_tmin += val[:tmin]
        avg_precip += val[:precip]
      end
      p weathers
      {avg_tmax: avg_tmax / weathers.size, avg_tmin: avg_tmin / weathers.size, avg_precip: avg_precip / weathers.size}
    end
  end
end
