require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index without authentication" do
    get root_url
    assert_response :success
  end

  test "should display fortune telling cards" do
    get root_url
    assert_select "h1 span", "✨ 神秘の占い館 ✨"
    assert_select "h3", "タロット占い"
    assert_select "h3", "星座占い"
    assert_select "h3", "数秘術"
  end

  test "should have proper page structure" do
    get root_url
    assert_select "div.min-h-screen"
    assert_select "div.max-w-6xl"
    assert_select "div.grid"
  end

  test "should work with existing session" do
    user = users(:one)
    login_as(user)
    get root_url
    assert_response :success
  end

  test "should work after clearing session" do
    user = users(:one)
    login_as(user)
    reset!
    get root_url
    assert_response :success
  end
end
