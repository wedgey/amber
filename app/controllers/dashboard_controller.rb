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

    @farm.last_activities.each do |activity|
      if activity[:activity_id] == 1
        offset = 5
        watered = true
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
    result[DateTime.now.to_date] << 2 unless fertilized
    result[DateTime.now.to_date] << 3 unless chemicalled

    @last_activities = result.to_json

    @subfarms = @farm.sub_farms.to_ary.to_json

  end

  def new
    @sub_farm_activity = SubFarmActivity.new
  end
end
