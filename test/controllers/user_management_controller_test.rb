require "test_helper"

class UserManagementControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_management_index_url
    assert_response :success
  end
end
