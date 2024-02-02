# frozen_string_literal: true

# == User
# This model is used to store the user information
class User < ApplicationRecord
  # == Constants ============================================================
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  # == Relationships ========================================================
  has_many :evaluations, foreign_key: 'evaluator_id'
  has_many :enrollments
  has_many :presentations, through: :enrollments

  # == Validations ==========================================================
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true
end
