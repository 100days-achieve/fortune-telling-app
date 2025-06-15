require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get new" do
    get new_session_url
    assert_response :success
  end

  test "should create session with valid credentials" do
    post session_url, params: {
      email_address: @user.email_address,
      password: "password"
    }
    assert_redirected_to root_url
    assert authenticated?
  end

  test "should not create session with invalid credentials" do
    post session_url, params: {
      email_address: @user.email_address,
      password: "wrong_password"
    }
    assert_redirected_to new_session_path
    assert_not authenticated?
  end

  test "should destroy session" do
    login_as(@user)
    delete session_url
    assert_redirected_to new_session_path
    assert_not authenticated?
  end

  test "should redirect to login when accessing destroy without session" do
    delete session_url
    assert_redirected_to new_session_url
  end

  test "should create session record in database" do
    assert_difference "Session.count", 1 do
      post session_url, params: {
        email_address: @user.email_address,
        password: "password"
      }
    end
  end
end
