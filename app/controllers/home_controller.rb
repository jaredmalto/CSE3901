# frozen_string_literal: true

# HomeController handles the landing page or main dashboard of the application.
# It ensures that users are authenticated before accessing the index action.
class HomeController < ApplicationController
  # Ensures that only authenticated users can access the index action.
  before_action :authenticate_user!

  # Renders the main landing page.
  def index; end
end
