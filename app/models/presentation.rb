# frozen_string_literal: true

# == Presentation
# This model is used to store the presentation information
class Presentation < ApplicationRecord
  # == Relationships ========================================================
  has_many :evaluations
  has_many :enrollments
  has_many :users, through: :enrollments

  # == Validations ==========================================================
  validates :title, presence: true
  validates :description, presence: true
  validates :date, presence: true
end
