require "test_helper"

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test "should have authentication system available" do
    user = users(:one)
    login_as(user)
    assert authenticated?
  end
end
