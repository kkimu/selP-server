require 'test_helper'

class JidorisControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get jidoris_index_url
    assert_response :success
  end

  test "should get new" do
    get jidoris_new_url
    assert_response :success
  end

end
