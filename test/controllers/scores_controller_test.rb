require 'test_helper'

class ScoresControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  fixtures :all
  def setup
    @user_one = users(:user_one)
    @presentation_one = presentations(:presentation_one)
    @presentation_two = presentations(:presentation_two)
    sign_in @user_one
  end

  test 'should show evaluations and presentations for a user' do
    get :index, session: { user_id: @user_one.id }
    assert_response :success
    assert_not_nil assigns(:evaluations)
    assert_not_nil assigns(:presentations)
  end

  test 'should get new evaluation form' do
    get :new, params: { presentation_id: @presentation_two.id }, session: { user_id: @user_one.id }
    assert_response :success
    assert_not_nil assigns(:presentation)
    assert_not_nil assigns(:evaluation)
  end

  test 'should create evaluation' do
    assert_difference 'Evaluation.count', 1 do
      post :create,
           params: { presentation_id: @presentation_two.id, evaluation: { organization_score: 3, content_score: 4, visuals_score: 5, delivery_score: 4 } }, session: { user_id: @user_one.id }
    end
    assert_redirected_to scores_path
    assert_equal 'Scores were successfully submitted.', flash[:notice]
  end

  test 'should calculate overall score for a presentation' do
    evaluation = Evaluation.new(organization_score: 3, content_score: 4, visuals_score: 5, delivery_score: 4)
    overall_score = @controller.send(:calculate_overall, evaluation)
    assert_equal 3, overall_score
  end
end
