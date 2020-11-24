require 'test_helper'

class VisitsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get visits_index_url
    assert_response :success
  end

  test "should get update" do
    get visits_update_url
    assert_response :success
  end

  test "should get destroy" do
    get visits_destroy_url
    assert_response :success
  end

  test "should get show" do
    get visits_show_url
    assert_response :success
  end

end
