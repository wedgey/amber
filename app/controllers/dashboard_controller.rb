class DashboardController < ApplicationController
  def show
    redirect_to root_path if !logged_in?
    @user = User.find(current_user)
    @farm = @user.farms.exists?(params[:id]) ? @user.farms.find(params[:id]) : @user.farms.first
    @activities = Activity.all
    @water_activity = {}
    @farm.last_watered.each do |ele|
      @water_activity[ele.sub_farm_id] = ele.date
    end

    @fertilizer_activity = {}
    @farm.last_fertilized.each do |ele|
      @fertilizer_activity[ele.sub_farm_id] = ele.date
    end

    @chemical_activity = {}
    @farm.last_chemicalled.each do |ele|
      @chemical_activity[ele.sub_farm_id] = ele.date
    end

    @water_activity = @water_activity.to_json
    @chemical_activity = @chemical_activity.to_json
    @fertilizer_activity = @fertilizer_activity.to_json
  end

  def new
    @sub_farm_activity = SubFarmActivity.new
  end
end
