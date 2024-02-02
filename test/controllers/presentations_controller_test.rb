require 'test_helper'

class PresentationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  fixtures :all
  def setup
    @user = users(:user_one)
  end

  test 'should get not_evaluated' do
    sign_in @user
    get presentations_not_evaluated_url
    assert_response :success
  end

  test 'should get not_evaluated when user is logged in' do
    sign_in @user
    get '/presentations/not_evaluated'
    assert_response :success
  end

  test 'should show presentation when user is logged in' do
    sign_in @user
    presentation = presentations(:presentation_one)
    get '/presentations', params: { id: presentation.id }
    assert_response :success
  end

  test 'should not show presentation when user is not logged in' do
    presentation = presentations(:presentation_one)
    assert_raises NoMethodError do
      get '/presentations', params: { id: presentation.id }
    end
  end

  test 'should get not not_evaluated when user is not logged in' do
    assert_raises NoMethodError do
      get '/presentations/not_evaluated'
    end
  end

  test 'should not get not_evaluated' do
    assert_raises NoMethodError do
      get presentations_not_evaluated_url
    end
  end
end
