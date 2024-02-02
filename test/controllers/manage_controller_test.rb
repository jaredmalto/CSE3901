require 'test_helper'

class ManageControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  fixtures :all
  def setup
    @user_one = users(:user_one)
    @user_two = users(:user_two)
    @presentation_one = presentations(:presentation_one)
    @presentation_two = presentations(:presentation_two)
  end

  test 'should not delete teacher' do
    @user_one.update(role: 'teacher')
    get :delete_user, params: { id: @user_one.id }
    assert_redirected_to manage_users_path
    assert_equal 'Cannot delete teacher.', flash[:notice]
  end

  test 'should delete user and associated data' do
    assert_difference ['User.count', 'Presentation.count', 'Enrollment.count'], -1 do
      get :delete_user, params: { id: @user_two.id }
    end
    assert_redirected_to manage_users_path
    assert_equal 'User was successfully deleted.', flash[:notice]
  end

  test 'should not create user if validation fails' do
    assert_no_difference 'User.count' do
      post :create_user, params: { user: { username: '', email: 'invalid_email', password: '123', role: 'student' } }
    end
    assert_template 'add_user'
  end

  test 'should create user' do
    assert_difference 'User.count', 1 do
      post :create_user,
           params: { user: { username: 'new_user', email: 'new_user@example.com', password: 'password',
                             role: 'student' } }
    end
    assert_redirected_to manage_users_path
    assert_equal 'User was successfully created.', flash[:notice]
  end

  test 'should delete presentation and associated enrollments' do
    assert_difference ['Presentation.count', 'Enrollment.count'], -1 do
      get :delete_presentation, params: { presentation_id: @presentation_one.id }
    end
    assert_redirected_to manage_users_path
    assert_equal 'Presentation deleted successfully.', flash[:notice]
  end
end
