class SubFarm < ApplicationRecord
  belongs_to :farm
  belongs_to :crop
  has_many :sub_farm_activities

  MAX_PROB = 0.90

  def calculate_yield
    forecasts = WeatherLog.forecast(farm.lat, farm.lng)
    stages = crop.stages

    #TODO calculate yield


  end

  private

  def calculate_differential(ideal_tmax, ideal_tmin, pas_max, pas_tmin, cur_tmax, cur_tmin, tmax_diff, tmin_diff)
    if (ideal_tmax - cur_tmax).abs >= (ideal_tmax - pas_tmax).abs
      tmax_prob = MAX_PROB * tmax_diff
    else
      tmax_prob = MAX_PROB / tmax_diff
    end

    if (ideal_tmin - cur_tmin).abs >= (ideal_tmin - pas_tmin).abs
      tmin_prob = MAX_PROB * tmin_diff
    else
      tmin_prob = MAX_PROB / tmin_diff
    end

    (tmax_prob - tmin_prob) / 2
  end
end
