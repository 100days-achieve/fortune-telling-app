require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get new" do
    get new_password_url
    assert_response :success
  end

  test "should create password reset request with valid email" do
    post passwords_url, params: {
      email_address: @user.email_address
    }
    assert_redirected_to new_session_url
    assert_match /password reset instructions/i, flash[:notice]
  end

  test "should create password reset request with invalid email" do
    post passwords_url, params: {
      email_address: "invalid@example.com"
    }
    assert_redirected_to new_session_url
    assert_match /password reset instructions/i, flash[:notice]
  end

  test "should create password reset request with missing email" do
    post passwords_url, params: {}
    assert_redirected_to new_session_url
    assert_match /password reset instructions/i, flash[:notice]
  end
end
