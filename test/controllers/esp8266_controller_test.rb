require "test_helper"

class Esp8266ControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get esp8266_index_url
    assert_response :success
  end
end
