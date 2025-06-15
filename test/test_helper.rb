ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    parallelize(workers: :number_of_processors)
    fixtures :all
  end
end

class ActionDispatch::IntegrationTest
  def login_as(user)
    post session_url, params: {
      email_address: user.email_address,
      password: "password"
    }
  end

  def authenticated?
    cookies[:session_id].present?
  end
end
