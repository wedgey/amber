require 'test_helper'

class CropsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @crop = crops(:one)
  end

  test "should get index" do
    get crops_url
    assert_response :success
  end

  test "should get new" do
    get new_crop_url
    assert_response :success
  end

  test "should create crop" do
    assert_difference('Crop.count') do
      post crops_url, params: { crop: { duration: @crop.duration, name: @crop.name } }
    end

    assert_redirected_to crop_url(Crop.last)
  end

  test "should show crop" do
    get crop_url(@crop)
    assert_response :success
  end

  test "should get edit" do
    get edit_crop_url(@crop)
    assert_response :success
  end

  test "should update crop" do
    patch crop_url(@crop), params: { crop: { duration: @crop.duration, name: @crop.name } }
    assert_redirected_to crop_url(@crop)
  end

  test "should destroy crop" do
    assert_difference('Crop.count', -1) do
      delete crop_url(@crop)
    end

    assert_redirected_to crops_url
  end
end
