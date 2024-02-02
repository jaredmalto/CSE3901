require 'test_helper'

class EvaluationTest < ActiveSupport::TestCase
  # set necessary fixtures for this test
  fixtures :users, :presentations
  test 'should not save evaluation without presentation_id and evaluator_id' do
    evaluation = Evaluation.new
    assert_not evaluation.save, 'Saved the evaluation without presentation_id and evaluator_id'
  end

  test 'should not save evaluation with invalid presentation_id' do
    user = users(:user_one)
    evaluation = Evaluation.new(presentation_id: 0, evaluator_id: user.id)
    assert_raises ActiveRecord::RecordInvalid do
      evaluation.save!
    end
  end

  test 'should not save evaluation with invalid evaluator_id' do
    presentation = presentations(:presentation_one)
    invalid_evaluator_id = 0 # Replace with an invalid ID
    assert_raises ActiveRecord::RecordInvalid do
      Evaluation.new(presentation_id: presentation.id, evaluator_id: invalid_evaluator_id).save!
    end
  end

  test 'should save evaluation with valid information' do
    presentation = presentations(:presentation_one)
    user = users(:user_one)
    evaluation = Evaluation.new(presentation_id: presentation.id, evaluator_id: user.id, organization_score: 5,
                                content_score: 5, visuals_score: 5, delivery_score: 5)
    assert evaluation.save, 'Could not save the evaluation with valid information'
  end
end
