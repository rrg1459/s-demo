require 'test_helper'

class RecibirControllerTest < ActionDispatch::IntegrationTest
  test "should get sms" do
    get recibir_sms_url
    assert_response :success
  end

end
