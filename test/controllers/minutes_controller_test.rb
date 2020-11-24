require 'test_helper'

class MinutesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get minutes_create_url
    assert_response :success
  end

end
