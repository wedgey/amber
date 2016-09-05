class WeatherLogsController < ApplicationController
  before_action :set_weather_log, only: [:show, :edit, :update, :destroy]

  # GET /weather_logs
  # GET /weather_logs.json
  def index
    @weather_logs = WeatherLog.all

    # Here you would make the api call to weather server and populate all the arrays
    # @dates = []
    # @temperatures = []
  end

  # GET /weather_logs/1
  # GET /weather_logs/1.json
  def show
  end

  # GET /weather_logs/new
  def new
    @weather_log = WeatherLog.new
  end

  # GET /weather_logs/1/edit
  def edit
  end

  # POST /weather_logs
  # POST /weather_logs.json
  def create
    @weather_log = WeatherLog.new(weather_log_params)

    respond_to do |format|
      if @weather_log.save
        format.html { redirect_to @weather_log, notice: 'Weather log was successfully created.' }
        format.json { render :show, status: :created, location: @weather_log }
      else
        format.html { render :new }
        format.json { render json: @weather_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weather_logs/1
  # PATCH/PUT /weather_logs/1.json
  def update
    respond_to do |format|
      if @weather_log.update(weather_log_params)
        format.html { redirect_to @weather_log, notice: 'Weather log was successfully updated.' }
        format.json { render :show, status: :ok, location: @weather_log }
      else
        format.html { render :edit }
        format.json { render json: @weather_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weather_logs/1
  # DELETE /weather_logs/1.json
  def destroy
    @weather_log.destroy
    respond_to do |format|
      format.html { redirect_to weather_logs_url, notice: 'Weather log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_weather
    current = open("http://api.wunderground.com/api/#{ENV['WUNDERGROUND_API_KEY']}/forecast10day/q/#{4.944.to_f},#{114.928.to_f}.json")
    forecast = JSON.parse(current.read)
    render json: forecast.to_json
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weather_log
      @weather_log = WeatherLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weather_log_params
      params.require(:weather_log).permit(:lat, :lng, :tmax, :tmin, :precip, :date)
    end
end
