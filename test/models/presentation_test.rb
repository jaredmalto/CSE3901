require 'test_helper'

class PresentationTest < ActiveSupport::TestCase
  test 'should not save presentation without title, description, and date' do
    presentation = Presentation.new
    assert_not presentation.save, 'Could save the presentation without title, description, and date'
  end

  test 'should save presentation with valid information' do
    presentation = Presentation.new(title: 'Sample Presentation', description: 'Description of the presentation',
                                    date: Date.today)
    assert presentation.save, 'Could not save the presentation with valid information'
  end
end
