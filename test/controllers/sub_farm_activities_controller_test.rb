require 'test_helper'

class SubFarmActivitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sub_farm_activity = sub_farm_activities(:one)
  end

  test "should get index" do
    get sub_farm_activities_url
    assert_response :success
  end

  test "should get new" do
    get new_sub_farm_activity_url
    assert_response :success
  end

  test "should create sub_farm_activity" do
    assert_difference('SubFarmActivity.count') do
      post sub_farm_activities_url, params: { sub_farm_activity: { activity_id: @sub_farm_activity.activity_id, amount: @sub_farm_activity.amount, date: @sub_farm_activity.date, note: @sub_farm_activity.note, sub_farm_id: @sub_farm_activity.sub_farm_id, title: @sub_farm_activity.title } }
    end

    assert_redirected_to sub_farm_activity_url(SubFarmActivity.last)
  end

  test "should show sub_farm_activity" do
    get sub_farm_activity_url(@sub_farm_activity)
    assert_response :success
  end

  test "should get edit" do
    get edit_sub_farm_activity_url(@sub_farm_activity)
    assert_response :success
  end

  test "should update sub_farm_activity" do
    patch sub_farm_activity_url(@sub_farm_activity), params: { sub_farm_activity: { activity_id: @sub_farm_activity.activity_id, amount: @sub_farm_activity.amount, date: @sub_farm_activity.date, note: @sub_farm_activity.note, sub_farm_id: @sub_farm_activity.sub_farm_id, title: @sub_farm_activity.title } }
    assert_redirected_to sub_farm_activity_url(@sub_farm_activity)
  end

  test "should destroy sub_farm_activity" do
    assert_difference('SubFarmActivity.count', -1) do
      delete sub_farm_activity_url(@sub_farm_activity)
    end

    assert_redirected_to sub_farm_activities_url
  end
end
