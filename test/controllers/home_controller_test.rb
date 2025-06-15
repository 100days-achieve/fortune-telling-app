require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index without authentication" do
    get root_url
    assert_response :success
    assert_select "title", /Fortune Telling App/
  end

  test "should display main heading" do
    get root_url
    assert_select "h1 span", /神秘の占い館/
  end

  test "should display fortune cards" do
    get root_url
    assert_select ".grid", 1
    assert_select "h3", "タロット占い"
    assert_select "h3", "星座占い"
    assert_select "h3", "数秘術"
  end

  test "should display today's fortune section" do
    get root_url
    assert_select "h2", /今日のあなたの運勢/
  end

  test "should have mystical gradient background" do
    get root_url
    assert_select ".mystical-gradient"
  end

  test "should be accessible without login" do
    # セッションをクリア
    reset!

    get root_url
    assert_response :success
    assert_no_match /new_session_path/, response.body
  end

  test "should have responsive design classes" do
    get root_url
    assert_select ".grid-cols-1"
    assert_select ".md\\:grid-cols-3"
  end

  test "should display fortune card icons" do
    get root_url
    assert_select ".text-5xl", text: "🔮"
    assert_select ".text-5xl", text: "⭐"
    assert_select ".text-5xl", text: "🔢"
  end
end
