class DashboardController < ApplicationController
  def show
    redirect_to root_path if !logged_in?
    @user = User.find(current_user)
    @farm = @user.farms.exists?(params[:id]) ? @user.farms.find(params[:id]) : @user.farms.first
    @activities = Activity.all
    # @water_activity = {}
    # @farm.last_watered.each do |ele|
    #   @water_activity[ele.sub_farm_id] = ele.date
    # end

    # @fertilizer_activity = {}
    # @farm.last_fertilized.each do |ele|
    #   @fertilizer_activity[ele.sub_farm_id] = ele.date
    # end

    # @chemical_activity = {}
    # @farm.last_chemicalled.each do |ele|
    #   @chemical_activity[ele.sub_farm_id] = ele.date
    # end

    # @water_activity = @farm.last_watered.first
    # @chemical_activity = @farm.last_chemicalled.first
    # @fertilizer_activity = @farm.last_fertilized.first

    # @water_activity = @water_activity.to_json
    # @chemical_activity = @chemical_activity.to_json
    # @fertilizer_activity = @fertilizer_activity.to_json

    result = Hash.new { |hash, key| hash[key] =  Array.new }

    watered = false
    fertilized = false
    chemicalled = false
    @day_to_water = DateTime.now.to_date

    @farm.last_activities.each do |activity|
      next if activity[:activity_id] == 4
      if activity[:activity_id] == 1
        offset = 5
        watered = true
        @day_to_water = offset.days.since(activity[:date].to_date)
      end
      if activity[:activity_id] == 2
        offset = 10 
        fertilized = true
      end
      if activity[:activity_id] == 3
        offset = 14
        chemicalled = true
      end

      result[offset.days.since(activity[:date].to_date)] << activity[:activity_id]
      result[10.days.since(activity[:date].to_date)] << activity[:activity_id] if activity[:activity_id] == 1
    end 

    result[DateTime.now.to_date] << 1 unless watered
    result[5.days.since(DateTime.now.to_date)] << 1 unless watered
    result[DateTime.now.to_date] << 2 unless fertilized
    result[DateTime.now.to_date] << 3 unless chemicalled

    @day_to_water = @day_to_water.to_json
    @last_activities = result.to_json
    @subfarms = @farm.sub_farms.to_ary.to_json
    next_harvest_farm = @farm.sub_farms.order(harvest_date: :desc).first

    @days_to_harvest = next_harvest_farm.to_json
    @potential_yield = next_harvest_farm.calculate_yield.to_json

  end

  def new
    @sub_farm_activity = SubFarmActivity.new
  end
end
