# frozen_string_literal: true

# ManageController handles the manage users page.
class ManageController < ApplicationController
  # Load in the manage users view
  def users
    @users = User.all
  end

  # Delete a user and all associated data
  def delete_user
    # Find the user
    @user = User.find(params[:id])
    # If the user is a teacher then redirect to manage users with a notice
    return redirect_to manage_users_path, notice: 'Cannot delete teacher.' if cannot_delete_teacher?

    # Delete all user related data, then delet the user
    delete_user_related_data
    @user.destroy
    # Redirect to manage users with a notice
    redirect_to manage_users_path, notice: 'User was successfully deleted.'
  rescue StandardError
    redirect_to root_path
  end

  # Load in the add user view
  def add_user
    @user = User.new
  end

  # Create a user with the given parameters
  def create_user
    @user = User.new(user_params)
    # If the user is saved successfully then redirect to manage users
    if @user.save
      redirect_to manage_users_path, notice: 'User was successfully created.'
    else
      render 'add_user'
    end
  end

  # Load in the add presentation view, giving necessary information
  def add_presentation
    @presentation = Presentation.new
    # So that we can Have a dropdown of students only
    @students = User.where(role: 'student').pluck(:username, :id)
  end

  # Create a presentation and enroll students to it
  def create_presentation
    # Create the presentation
    @presentation = Presentation.new(presentation_params)
    # If the presentation is saved successfully then do the other operations
    if @presentation.save
      # Assuming you are getting an array of selected user_ids from the form
      user_ids = params[:presentation][:user_ids]
      # Create enrollments for each selected user and the created presentation
      user_ids.each do |user_id|
        Enrollment.create(user_id:, presentation_id: @presentation.id)
      end
      # Redirect to presentations index
      redirect_to presentations_path, notice: 'Presentation created successfully.'
    # If the presentation is not saved successfully then render the add_presentation view
    else
      render :add_presentation
    end
  end

  # Delete a presentation and all associated enrollments
  def delete_presentation
    # Find the presentation
    @presentation = Presentation.find(params[:presentation_id])
    # Delete associated enrollments when deleting the presentation
    Enrollment.where(presentation_id: @presentation.id).destroy_all
    @presentation.destroy
    # Redirect to presentations index
    redirect_to manage_users_path, notice: 'Presentation deleted successfully.'
  end

  # Update a given presentation with a new field if given.
  def update_presentation(presentation_id, title, description, due_date)
    @presentation = Presentation.find(presentation_id)

    # Update only the specified fields
    @presentation.title = title if title.present?
    @presentation.description = description if description.present?
    @presentation.date = due_date if due_date.present?

    @presentation.save
  end

  private

  # Check if the user is a teacher
  def cannot_delete_teacher?
    @user.role == 'teacher'
  end

  # Delete all user related data
  def delete_user_related_data
    delete_user_enrollments
    delete_empty_presentations
    delete_user_evaluations
  end

  # Delete all user enrollments
  def delete_user_enrollments
    Enrollment.where(user_id: @user.id).destroy_all
  end

  # Delete all presentations that have no enrollments
  def delete_empty_presentations
    Presentation.where.not(id: presentations_with_enrollments).destroy_all
  end

  # Get all presentations that have enrollments
  def presentations_with_enrollments
    Enrollment.select(:presentation_id).distinct.pluck(:presentation_id)
  end

  # Delete all evaluations that the user has made
  def delete_user_evaluations
    Evaluation.where(evaluator_id: @user.id).destroy_all
  end

  # Whitelists permitted user parameters
  def user_params
    params.require(:user).permit(:username, :email, :password, :role)
  end

  # Whitelists permitted presentation parameters
  def presentation_params
    params.require(:presentation).permit(:title, :description, :date, user_ids: [])
  end
end
