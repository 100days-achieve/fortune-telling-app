require "test_helper"

class CurrentTest < ActiveSupport::TestCase
  test "should be a CurrentAttributes class" do
    assert_kind_of ActiveSupport::CurrentAttributes, Current.new
  end

  test "should have session attribute" do
    assert_respond_to Current, :session
    assert_respond_to Current, :session=
  end

  test "should delegate user to session" do
    user = users(:one)
    session = sessions(:one)
    session.user = user

    Current.session = session
    assert_equal user, Current.user
  end

  test "should return nil user when session is nil" do
    Current.session = nil
    assert_nil Current.user
  end

  test "should return nil user when session has no user" do
    session = Session.new
    Current.session = session
    assert_nil Current.user
  end

  test "should allow setting and getting session" do
    session = sessions(:one)
    Current.session = session
    assert_equal session, Current.session
  end

  test "should reset attributes" do
    Current.session = sessions(:one)
    assert_not_nil Current.session

    Current.reset
    assert_nil Current.session
    assert_nil Current.user
  end
end
