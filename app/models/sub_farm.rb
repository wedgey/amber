class SubFarm < ApplicationRecord
  belongs_to :farm
  belongs_to :crop
  has_many :sub_farm_activities

  MAX_PROB = 0.90

  def calculate_yield
    forecasts = WeatherLog.forecast(farm.lat, farm.lng)
    p "hello #{farm.lat}"
    stages = crop.stages

    #TODO calculate yield

  end

  private

  def calculate_differential(idealTmax, idealTmin, pasTmax, pasTmin, curTmax, curTmin, TmaxDiff, TminDiff)
    if (idealTmax - curTmax).abs >= (idealTmax - pasTmax).abs
      TmaxProb = MAX_PROB * TmaxDiff
    else
      TmaxProb = MAX_PROB / TmaxDiff
    end

    if (idealTmin - curTmin).abs >= (idealTmin - pasTmin).abs
      TminProb = MAX_PROB * TminDiff
    else
      TminProb = MAX_PROB / TminDiff
    end

    (TmaxProb - TminProb) / 2
  end
end
