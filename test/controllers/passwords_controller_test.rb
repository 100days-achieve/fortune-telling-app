require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get new" do
    get new_password_url
    assert_response :success
    assert_select "form"
    assert_select "input[name='email_address']"
  end

  test "should create password reset request with valid email" do
    post passwords_url, params: {
      email_address: @user.email_address
    }
    assert_redirected_to new_session_url
    assert_match /password reset instructions/i, flash[:notice]
  end

  test "should not create password reset request with invalid email" do
    post passwords_url, params: {
      email_address: "invalid@example.com"
    }
    assert_response :unprocessable_entity
    assert_select ".alert"
  end

  test "should not create password reset request with missing email" do
    post passwords_url, params: {}
    assert_response :unprocessable_entity
  end

  test "should get edit with valid token" do
    # パスワードリセットトークンを生成（実際の実装に応じて調整）
    token = "valid_token_example"
    get edit_password_url(token: token)
    assert_response :success
    assert_select "form"
    assert_select "input[name='password']"
    assert_select "input[name='password_confirmation']"
  end

  test "should not get edit with invalid token" do
    get edit_password_url(token: "invalid_token")
    assert_redirected_to new_password_url
    assert_match /invalid.*token/i, flash[:alert]
  end

  test "should not get edit without token" do
    get edit_password_url(token: "")
    assert_redirected_to new_password_url
  end

  test "should update password with valid token and password" do
    # パスワードリセットトークンを生成（実際の実装に応じて調整）
    token = "valid_token_example"

    patch password_url(token: token), params: {
      password: "newpassword123",
      password_confirmation: "newpassword123"
    }

    assert_redirected_to new_session_url
    assert_match /password.*updated/i, flash[:notice]
  end

  test "should not update password with mismatched confirmation" do
    token = "valid_token_example"

    patch password_url(token: token), params: {
      password: "newpassword123",
      password_confirmation: "differentpassword"
    }

    assert_response :unprocessable_entity
    assert_select ".alert"
  end

  test "should not update password with short password" do
    token = "valid_token_example"

    patch password_url(token: token), params: {
      password: "short",
      password_confirmation: "short"
    }

    assert_response :unprocessable_entity
    assert_select ".alert"
  end

  test "should not update password with invalid token" do
    patch password_url(token: "invalid_token"), params: {
      password: "newpassword123",
      password_confirmation: "newpassword123"
    }

    assert_redirected_to new_password_url
    assert_match /invalid.*token/i, flash[:alert]
  end
end
