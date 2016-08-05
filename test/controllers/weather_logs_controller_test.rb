require 'test_helper'

class WeatherLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @weather_log = weather_logs(:one)
  end

  test "should get index" do
    get weather_logs_url
    assert_response :success
  end

  test "should get new" do
    get new_weather_log_url
    assert_response :success
  end

  test "should create weather_log" do
    assert_difference('WeatherLog.count') do
      post weather_logs_url, params: { weather_log: { date: @weather_log.date, lat: @weather_log.lat, lng: @weather_log.lng, precip: @weather_log.precip, tmax: @weather_log.tmax, tmin: @weather_log.tmin } }
    end

    assert_redirected_to weather_log_url(WeatherLog.last)
  end

  test "should show weather_log" do
    get weather_log_url(@weather_log)
    assert_response :success
  end

  test "should get edit" do
    get edit_weather_log_url(@weather_log)
    assert_response :success
  end

  test "should update weather_log" do
    patch weather_log_url(@weather_log), params: { weather_log: { date: @weather_log.date, lat: @weather_log.lat, lng: @weather_log.lng, precip: @weather_log.precip, tmax: @weather_log.tmax, tmin: @weather_log.tmin } }
    assert_redirected_to weather_log_url(@weather_log)
  end

  test "should destroy weather_log" do
    assert_difference('WeatherLog.count', -1) do
      delete weather_log_url(@weather_log)
    end

    assert_redirected_to weather_logs_url
  end
end
