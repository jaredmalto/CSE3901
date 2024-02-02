# frozen_string_literal: true

# ScoresController handles the evaluation of presentations.
class ScoresController < ApplicationController
  MAX_SCORE = 43

  # Shows all of the evaluations that a user has given.
  def index
    @evaluations = Evaluation.where(evaluator_id: current_user.id)
    @presentations = Presentation.where(id: @evaluations.pluck(:presentation_id))
  end

  # Allows a user to evaluate a presentation.
  def new
    # Get the presentation
    @presentation = Presentation.find(params[:presentation_id])
    # Redirect to scores index if the user has already evaluated the presentation
    if Evaluation.exists?(presentation_id: @presentation.id, evaluator_id: current_user.id)
      return redirect_to scores_path, notice: 'Presentation already evaluated.'
    end

    # Create a new evaluation
    @evaluation = Evaluation.new
  end

  # Creates a new evaluation for a presentation.
  def create
    # Get the presentation
    @presentation = Presentation.find(params[:presentation_id])
    # Create the evaluation
    @evaluation = @presentation.evaluations.build(evaluation_params.merge(evaluator_id: current_user.id))
    # Save the evaluation to the table
    if @evaluation.save
      redirect_to scores_path, notice: 'Scores were successfully submitted.'
    else
      render :new
    end
  end

  private

  # Calculates the overall score of a presentation
  def calculate_overall(evaluation)
    # We want the max score to be 5 and the min to be 1
    # Add the total score and ensure that it is positive
    net_score = evaluation.organization_score + evaluation.content_score + evaluation.visuals_score + evaluation.delivery_score + MAX_SCORE
    (2 * net_score / MAX_SCORE).round + 1
  end

  # Whitelists permitted evaluation parameters
  def evaluation_params
    params.require(:evaluation).permit(:organization_score, :content_score, :visuals_score, :delivery_score, :comment)
  end
end
