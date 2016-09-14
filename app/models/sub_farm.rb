class SubFarm < ApplicationRecord
  belongs_to :farm
  belongs_to :crop
  has_many :sub_farm_activities, dependent: :destroy

  validates :size, numericality: true
  validates :crop_weight, numericality: true
  

  MAX_PROB = 0.90

  def calculate_yield
    
    forecasts = WeatherLog.forecast(farm.lat, farm.lng)

    return nil unless( crop_weight and forecasts )

    stages = crop.stages
    
    first_prob = calculate_differential(stages.first.tmax, stages.first.tmin, forecasts[:forecasts][:avgs][:first][:avg_tmax], forecasts[:forecasts][:avgs][:first][:avg_tmin])
    
    second_prob = calculate_differential(stages.second.tmax, stages.second.tmin, forecasts[:forecasts][:avgs][:second][:avg_tmax], forecasts[:forecasts][:avgs][:second][:avg_tmin])
    
    third_prob = calculate_differential(stages.third.tmax, stages.third.tmin, forecasts[:forecasts][:avgs][:third][:avg_tmax], forecasts[:forecasts][:avgs][:third][:avg_tmin])

    # p "#{first_prob} and #{second_prob} and #{third_prob}"

    survival_rate = MAX_PROB * first_prob * second_prob * third_prob

    seeds = crop_weight * 1000 / crop.seed_weight # Convert crop weight from kg to g
    num_products = seeds * crop.product_plant
    # crop_yield = crop.product_plant * survived_plant # Convert product per plant from kg to g\
    crop_yield = num_products * survival_rate

    # crop_yield.to_f # yield is in grams
    ((crop_yield / 1000) / size).to_f.round(2) # yield in kg
  end

  private

  def calculate_differential(ideal_tmax, ideal_tmin, fore_tmax, fore_tmin)
    # if (ideal_tmax - cur_tmax).abs >= (ideal_tmax - pas_tmax).abs
    #   tmax_prob = MAX_PROB * cur_tmax / pas_tmax
    # else
    #   tmax_prob = MAX_PROB / cur_tmax / pas_tmax
    # end

    # if (ideal_tmin - cur_tmin).abs >= (ideal_tmin - pas_tmin).abs
    #   tmin_prob = MAX_PROB * cur_tmin / pas_tmin
    # else
    #   tmin_prob = MAX_PROB / cur_tmin / pas_tmin
    # end

    tmax_prob = ((ideal_tmax * 9)/5 + 32) / fore_tmax
    tmin_prob = ((ideal_tmin * 9)/5 + 32) / fore_tmin

    tmax_prob = (tmax_prob - 2).abs if tmax_prob > 1
    tmin_prob = (tmin_prob - 2).abs if tmin_prob > 1

    # {tmax: tmax_prob, tmin: tmin_prob}
    # p "First ideal_tmax: #{(ideal_tmax * 9)/5 + 32}, First ideal_tmin: #{(ideal_tmin * 9)/5 + 32}"
    # p "First Tmax: #{tmax_prob}, First tmin: #{tmin_prob}"
    # p "Prob = #{(tmax_prob + tmin_prob) / 2}"
    (tmax_prob + tmin_prob) / 2
  end
end
