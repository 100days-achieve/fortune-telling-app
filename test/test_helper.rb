ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

class ActionDispatch::IntegrationTest
  # ログインヘルパー
  def login_as(user)
    post session_url, params: {
      email_address: user.email_address,
      password: "password"
    }
  end

  # セッション作成ヘルパー
  def create_session_for(user)
    session = user.sessions.create!(
      user_agent: "Test Agent",
      ip_address: "127.0.0.1"
    )
    cookies.signed[:session_id] = session.id
    session
  end

  # 認証状態の確認ヘルパー
  def authenticated?
    cookies.signed[:session_id].present?
  end
end
