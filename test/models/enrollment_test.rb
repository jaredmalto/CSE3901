require 'test_helper'

class EnrollmentTest < ActiveSupport::TestCase
  fixtures :users, :presentations
  test 'should not save enrollment without user_id and presentation_id' do
    enrollment = Enrollment.new
    assert_not enrollment.save, 'Saved the enrollment without user_id and presentation_id'
  end

  test 'should not save enrollment with invalid user_id' do
    presentation = presentations(:presentation_one)
    enrollment = Enrollment.new(user_id: 0, presentation_id: presentation.id)
    assert_not enrollment.save, 'Saved the enrollment with invalid user_id'
  end

  test 'should not save enrollment with invalid presentation_id' do
    user = users(:user_one)
    enrollment = Enrollment.new(user_id: user.id, presentation_id: 0)
    assert_not enrollment.save, 'Saved the enrollment with invalid presentation_id'
  end

  test 'should save enrollment with valid information' do
    presentation = presentations(:presentation_one)
    user = users(:user_one)
    enrollment = Enrollment.new(user_id: user.id, presentation_id: presentation.id)
    assert enrollment.save, 'Could not save the enrollment with valid information'
  end
end
