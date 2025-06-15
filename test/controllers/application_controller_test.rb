require "test_helper"

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  # 認証が必要なダミーコントローラーを作成してテスト
  class TestProtectedController < ApplicationController
    def index
      render plain: "Protected content"
    end
  end

  class TestPublicController < ApplicationController
    allow_unauthenticated_access

    def index
      render plain: "Public content"
    end
  end

  test "should redirect to login when accessing protected content without authentication" do
    with_routing do |set|
      set.draw do
        get "/protected", to: "application_controller_test/test_protected#index"
        get "/sessions/new", to: "sessions#new", as: :new_session
      end

      get "/protected"
      assert_redirected_to new_session_path
    end
  end

  test "should allow access to public content without authentication" do
    with_routing do |set|
      set.draw do
        get "/public", to: "application_controller_test/test_public#index"
      end

      get "/public"
      assert_response :success
      assert_equal "Public content", response.body
    end
  end

  test "should allow access to protected content when authenticated" do
    # ログイン
    post session_url, params: {
      email_address: @user.email_address,
      password: "password"
    }

    with_routing do |set|
      set.draw do
        get "/protected", to: "application_controller_test/test_protected#index"
      end

      get "/protected"
      assert_response :success
      assert_equal "Protected content", response.body
    end
  end

  test "should set return_to_after_authenticating when redirected" do
    with_routing do |set|
      set.draw do
        get "/protected", to: "application_controller_test/test_protected#index"
        get "/sessions/new", to: "sessions#new", as: :new_session
      end

      get "/protected"
      assert_equal "/protected", session[:return_to_after_authenticating]
    end
  end

  test "should clear return_to_after_authenticating after successful login" do
    # 保護されたページにアクセス
    with_routing do |set|
      set.draw do
        get "/protected", to: "application_controller_test/test_protected#index"
        get "/sessions/new", to: "sessions#new", as: :new_session
        post "/sessions", to: "sessions#create", as: :sessions
        root to: "home#index"
      end

      get "/protected"
      assert_equal "/protected", session[:return_to_after_authenticating]

      # ログイン
      post session_url, params: {
        email_address: @user.email_address,
        password: "password"
      }

      # return_to がクリアされることを確認
      assert_nil session[:return_to_after_authenticating]
    end
  end
end
