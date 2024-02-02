# frozen_string_literal: true

# == Evaluation
# This model is used to store the evaluation of a presentation by a user
class Evaluation < ApplicationRecord
  # == Relationships ========================================================
  belongs_to :presentation
  belongs_to :user, foreign_key: 'evaluator_id', optional: true

  # == Validations ==========================================================
  validates :presentation_id, presence: true
  validates :evaluator_id, presence: true
  validates :organization_score, presence: true
  validates :content_score, presence: true
  validates :visuals_score, presence: true
  validates :delivery_score, presence: true
end
