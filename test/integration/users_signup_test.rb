require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: {user: {name: "", email: "user@123", password: "foo", password_confirmation: "bar"}}
    end
    assert_template 'users/new'
    # assert_select 'div#<CSS id for error explanation'
    # assert_select 'div.<CSS class for field with error>'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path, params: {user: {name: "user", email: "user@qq.com", password: "123456", password_confirmation: "123456"}}
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
