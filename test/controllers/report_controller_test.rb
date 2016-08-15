require 'test_helper'

class ReportControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get report_show_url
    assert_response :success
  end

end
