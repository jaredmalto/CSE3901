require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  fixtures :all
  def setup
    @user = users(:user_one)
    sign_in @user
  end

  test 'should get index' do
    get '/'
    assert_response :success
  end
end
