require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should be valid with valid attributes" do
    user = User.new(email_address: "test@example.com", password: "password123")
    assert user.valid?
  end

  test "should require email_address" do
    user = User.new(password: "password123")
    assert_not user.valid?
    assert_includes user.errors[:email_address], "can't be blank"
  end

  test "should require password" do
    user = User.new(email_address: "test@example.com")
    assert_not user.valid?
  end

  test "should normalize email_address to lowercase and strip whitespace" do
    user = User.create!(email_address: "  TEST@EXAMPLE.COM  ", password: "password123")
    assert_equal "test@example.com", user.email_address
  end

  test "should have unique email_address" do
    User.create!(email_address: "test@example.com", password: "password123")
    duplicate_user = User.new(email_address: "test@example.com", password: "password123")
    assert_not duplicate_user.valid?
    assert_includes duplicate_user.errors[:email_address], "has already been taken"
  end

  test "should authenticate with correct password" do
    user = User.create!(email_address: "test@example.com", password: "password123")
    assert user.authenticate("password123")
    assert_not user.authenticate("wrongpassword")
  end

  test "should have secure password" do
    user = User.new(email_address: "test@example.com", password: "password123")
    assert_respond_to user, :authenticate
    assert_respond_to user, :password_digest
  end

  test "should have many sessions" do
    user = users(:one)
    assert_respond_to user, :sessions
    assert_equal "ActiveRecord::Associations::CollectionProxy", user.sessions.class.name
  end

      test "should destroy associated sessions when user is destroyed" do
    user = users(:one)
    # 新しいセッションを作成
    session = user.sessions.create!(user_agent: "Test Agent", ip_address: "127.0.0.1")
    session_id = session.id

    # ユーザーを削除
    user.destroy

    # セッションも削除されていることを確認
    assert_nil Session.find_by(id: session_id), "Session should be destroyed when user is destroyed"
  end

    test "should validate email format" do
    valid_emails = %w[
      user@example.com
      test.email@example.co.jp
      user+tag@example.org
    ]

    invalid_emails = %w[
      invalid_email
      @example.com
      user@
    ]

    valid_emails.each do |email|
      user = User.new(email_address: email, password: "password123")
      assert user.valid?, "#{email} should be valid"
    end

    invalid_emails.each do |email|
      user = User.new(email_address: email, password: "password123")
      assert_not user.valid?, "#{email} should be invalid"
    end
  end

  test "should require minimum password length" do
    user = User.new(email_address: "test@example.com", password: "short")
    assert_not user.valid?
    assert_includes user.errors[:password], "is too short (minimum is 6 characters)"
  end
end
