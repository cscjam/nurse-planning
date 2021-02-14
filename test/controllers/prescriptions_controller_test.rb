require 'test_helper'

class PrescriptionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get prescriptions_index_url
    assert_response :success
  end

  test "should get show" do
    get prescriptions_show_url
    assert_response :success
  end

  test "should get create" do
    get prescriptions_create_url
    assert_response :success
  end

  test "should get new" do
    get prescriptions_new_url
    assert_response :success
  end

  test "should get create" do
    get prescriptions_create_url
    assert_response :success
  end

  test "should get update" do
    get prescriptions_update_url
    assert_response :success
  end

  test "should get delete" do
    get prescriptions_delete_url
    assert_response :success
  end

end
