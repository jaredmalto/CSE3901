require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should not save user without username, email, and role' do
    user = User.new
    assert_not user.save, 'Saved the user without username, email, and role'
  end

  test 'should save user with valid information' do
    user = User.new(username: 'example_user', email: 'user@example.com', password: 'password', role: 'user')
    assert user.save, 'Could not save the user with valid information'
  end
end
