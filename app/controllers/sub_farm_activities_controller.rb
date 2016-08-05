class SubFarmActivitiesController < ApplicationController
  before_action :set_sub_farm_activity, only: [:show, :edit, :update, :destroy]

  # GET /sub_farm_activities
  # GET /sub_farm_activities.json
  def index
    @sub_farm_activities = SubFarmActivity.all
  end

  # GET /sub_farm_activities/1
  # GET /sub_farm_activities/1.json
  def show
  end

  # GET /sub_farm_activities/new
  def new
    @sub_farm_activity = SubFarmActivity.new
  end

  # GET /sub_farm_activities/1/edit
  def edit
  end

  # POST /sub_farm_activities
  # POST /sub_farm_activities.json
  def create
    @sub_farm_activity = SubFarmActivity.new(sub_farm_activity_params)

    respond_to do |format|
      if @sub_farm_activity.save
        format.html { redirect_to @sub_farm_activity, notice: 'Sub farm activity was successfully created.' }
        format.json { render :show, status: :created, location: @sub_farm_activity }
      else
        format.html { render :new }
        format.json { render json: @sub_farm_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sub_farm_activities/1
  # PATCH/PUT /sub_farm_activities/1.json
  def update
    respond_to do |format|
      if @sub_farm_activity.update(sub_farm_activity_params)
        format.html { redirect_to @sub_farm_activity, notice: 'Sub farm activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @sub_farm_activity }
      else
        format.html { render :edit }
        format.json { render json: @sub_farm_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_farm_activities/1
  # DELETE /sub_farm_activities/1.json
  def destroy
    @sub_farm_activity.destroy
    respond_to do |format|
      format.html { redirect_to sub_farm_activities_url, notice: 'Sub farm activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub_farm_activity
      @sub_farm_activity = SubFarmActivity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sub_farm_activity_params
      params.require(:sub_farm_activity).permit(:sub_farm_id, :activity_id, :amount, :date, :title, :note)
    end
end
