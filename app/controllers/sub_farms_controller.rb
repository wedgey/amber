require 'date'

class SubFarmsController < ApplicationController
  before_action :set_sub_farm, only: [:show, :edit, :update, :destroy]

  # GET /sub_farms
  # GET /sub_farms.json
  def index
    @sub_farms = SubFarm.all
  end

  # GET /sub_farms/1
  # GET /sub_farms/1.json
  def show
    @forecast = SubFarm.find(params[:id]).calculate_yield
    
    # @farm = Farm.find(params[:farm_id])
    # @forecast = WeatherLog.forecast(@farm.lat,@farm.lng)
  end

  # GET /sub_farms/new
  def new
    @farm = Farm.find(params[:farm_id])
    @sub_farm = SubFarm.new
    now = Date.today
    @sub_farm.harvest_date = (now + 100)
  end

  # GET /sub_farms/1/edit
  def edit
    @farm = Farm.find(params[:farm_id])
  end

  # POST /sub_farms
  # POST /sub_farms.json
  def create

    @sub_farm = SubFarm.new(sub_farm_params)
    @farm = Farm.find(@sub_farm.farm_id)

    respond_to do |format|
      if @sub_farm.save
        
        format.html { redirect_to @farm, notice: 'Sub farm was successfully created.' }
        format.json { render :show, status: :created, location: @sub_farm }
      else
        format.html { render :new }
        format.json { render json: @sub_farm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sub_farms/1
  # PATCH/PUT /sub_farms/1.json
  def update
    @farm = Farm.find(@sub_farm.farm_id)

    respond_to do |format|
      if @sub_farm.update(sub_farm_params)
        format.html { redirect_to @farm, notice: 'Sub farm was successfully updated.' }
        format.json { render :show, status: :ok, location: @sub_farm }
      else
        format.html { render :edit }
        format.json { render json: @sub_farm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_farms/1
  # DELETE /sub_farms/1.json
  def destroy
    @farm = Farm.find(@sub_farm.farm_id)
    @sub_farm.destroy
    # @sub_farm.active = false;
    # @sub_farm.save!
    
    respond_to do |format|
      format.html { redirect_to @farm, notice: 'Sub farm was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub_farm
      @sub_farm = SubFarm.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sub_farm_params
      params.require(:sub_farm).permit(:farm_id, :crop_id, :size, :crop_weight, :start_date, :harvest_date, :layout, :x, :y, :width, :height)
    end
end
