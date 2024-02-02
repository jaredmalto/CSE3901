# frozen_string_literal: true

# PresentationsController handles the presentation actions.
class PresentationsController < ApplicationController
  # Corresponds to the presentations view, allowing users to view all presentations
  # that they have not evaluated yet and are not assigned to.
  def not_evaluated
    # Get the IDs of presentations evaluated by the user
    presentations_evaluated_by_user = Evaluation.where(evaluator_id: current_user.id).pluck(:presentation_id)
    # Fetch presentations that haven't been evaluated by the user
    current_user_presentations = Enrollment.where(user_id: current_user.id).pluck(:presentation_id)
    # Fetch presentations that the user is not enrolled in
    @presentations_not_evaluated = Presentation.includes(:evaluations)
                                               .where.not(id: presentations_evaluated_by_user)
                                               .where.not(id: current_user_presentations)
                                               .distinct
  end

  # Corresponds to view that shows all of the presentations for teachers and tas.
  def index
    # Get all presentations in a particular order
    @presentations = Presentation.all.order('title ASC, updated_at DESC')
    # Get all evaluations, users, and enrollments
    @evaluations = Evaluation.all
    @users = User.all
    @enrollments = Enrollment.all
    return unless current_user.role == 'student'

    # Get all presentations that the student is enrolled in
    current_user_presentations = Enrollment.where(user_id: current_user.id).pluck(:presentation_id)
    @presentations = @presentations.where(id: current_user_presentations)
    # Get all evaluations that the student has made
    @evaluations = @evaluations.where(presentation_id: @presentations.ids)
  end

  # Corresponds to the view that shows a single presentation.
  def show
    # Get the presentation ID
    presentation_id = params[:id]
    # Get the presentation, evaluations, and users
    @presentation = Presentation.find(presentation_id)
    @evaluations = Evaluation.where(presentation_id:).order('updated_at DESC')
    @users = User.all

    # Redirect to presentations index if the user is a student and is not enrolled in the presentation
    unless current_user.role == 'student' && !Enrollment.exists?(presentation_id:,
                                                                 user_id: current_user.id)
      return
    end

    redirect_to presentations_path, notice: 'You do not have access to that presentation.'
    nil
  end
end
