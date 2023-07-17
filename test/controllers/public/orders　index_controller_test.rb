require "test_helper"

class Public::Orders　indexControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_orders　index_show_url
    assert_response :success
  end

  test "should get confirm" do
    get public_orders　index_confirm_url
    assert_response :success
  end

  test "should get complete" do
    get public_orders　index_complete_url
    assert_response :success
  end
end
