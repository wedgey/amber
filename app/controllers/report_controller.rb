class ReportController < ApplicationController
  def index
    @farms = current_user.farms
  end
end
