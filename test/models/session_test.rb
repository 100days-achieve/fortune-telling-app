require "test_helper"

class SessionTest < ActiveSupport::TestCase
  test "should belong to user" do
    session = Session.new
    assert_respond_to session, :user
  end

  test "should be valid with user" do
    session = Session.new(user: users(:one), user_agent: "Test Agent", ip_address: "127.0.0.1")
    assert session.valid?
  end

  test "should require user" do
    session = Session.new(user_agent: "Test Agent", ip_address: "127.0.0.1")
    assert_not session.valid?
    assert_includes session.errors[:user], "must exist"
  end

  test "should have user_agent and ip_address" do
    session = sessions(:one) if defined?(sessions)
    session ||= Session.create!(user: users(:one), user_agent: "Test Agent", ip_address: "127.0.0.1")

    assert_respond_to session, :user_agent
    assert_respond_to session, :ip_address
  end

  test "should be created with user association" do
    user = users(:one)
    session = user.sessions.create!(user_agent: "Test Browser", ip_address: "192.168.1.1")

    assert_equal user, session.user
    assert_includes user.sessions, session
  end

  test "should have timestamps" do
    session = Session.create!(user: users(:one), user_agent: "Test Agent", ip_address: "127.0.0.1")

    assert_not_nil session.created_at
    assert_not_nil session.updated_at
  end

  test "should be destroyable" do
    session = Session.create!(user: users(:one), user_agent: "Test Agent", ip_address: "127.0.0.1")
    session_id = session.id

    assert_difference "Session.count", -1 do
      session.destroy
    end

    assert_nil Session.find_by(id: session_id)
  end
end
