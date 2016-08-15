class DashboardController < ApplicationController
  def show
    @user = User.find(current_user)
    @farm = @user.farms.exists?(params[:id]) ? @user.farms.find(params[:id]) : @user.farms.first
    @activities = Activity.all
  end

  def new
    @sub_farm_activity = SubFarmActivity.new
  end
end
