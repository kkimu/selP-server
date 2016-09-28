require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get users_create_url
    assert_response :success
  end

  test "should get new" do
    get users_new_url
    assert_response :success
  end

  test "should get show" do
    get users_show_url
    assert_response :success
  end

  test "should get share_jidori" do
    get users_share_jidori_url
    assert_response :success
  end

end
