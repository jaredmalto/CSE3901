# frozen_string_literal: true

# ==  Enrollment
# This model is used to store the enrollment of a user to a presentation
class Enrollment < ApplicationRecord
  # == Relationships ========================================================
  belongs_to :user
  belongs_to :presentation
end
