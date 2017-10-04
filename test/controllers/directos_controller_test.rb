require 'test_helper'

class DirectosControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get directos_new_url
    assert_response :success
  end

  test "should get create" do
    get directos_create_url
    assert_response :success
  end

end
