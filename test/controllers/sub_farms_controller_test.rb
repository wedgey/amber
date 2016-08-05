require 'test_helper'

class SubFarmsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sub_farm = sub_farms(:one)
  end

  test "should get index" do
    get sub_farms_url
    assert_response :success
  end

  test "should get new" do
    get new_sub_farm_url
    assert_response :success
  end

  test "should create sub_farm" do
    assert_difference('SubFarm.count') do
      post sub_farms_url, params: { sub_farm: { crop_id: @sub_farm.crop_id, crop_weight: @sub_farm.crop_weight, farm_id: @sub_farm.farm_id, harvest_date: @sub_farm.harvest_date, layout: @sub_farm.layout, size: @sub_farm.size, start_date: @sub_farm.start_date } }
    end

    assert_redirected_to sub_farm_url(SubFarm.last)
  end

  test "should show sub_farm" do
    get sub_farm_url(@sub_farm)
    assert_response :success
  end

  test "should get edit" do
    get edit_sub_farm_url(@sub_farm)
    assert_response :success
  end

  test "should update sub_farm" do
    patch sub_farm_url(@sub_farm), params: { sub_farm: { crop_id: @sub_farm.crop_id, crop_weight: @sub_farm.crop_weight, farm_id: @sub_farm.farm_id, harvest_date: @sub_farm.harvest_date, layout: @sub_farm.layout, size: @sub_farm.size, start_date: @sub_farm.start_date } }
    assert_redirected_to sub_farm_url(@sub_farm)
  end

  test "should destroy sub_farm" do
    assert_difference('SubFarm.count', -1) do
      delete sub_farm_url(@sub_farm)
    end

    assert_redirected_to sub_farms_url
  end
end
