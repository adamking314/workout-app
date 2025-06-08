class Workout < ApplicationRecord
  # If you used a JSON column type, Rails will automatically cast to/from Hash/Array.
  # If you used a text column instead, you need to serialize it manually:
  #serialize :blocks, JSON

  validates :workout_name, presence: true
  validates :username,     presence: true
  has_many :saved_workouts, dependent: :destroy
  has_many :users_who_saved,
           through: :saved_workouts,
           source: :user
  # … any other validations …

  # (Optional) A helper method to count blocks/exercises:
  def total_blocks
    (blocks || []).size
  end

  def total_exercises
    (blocks || []).sum { |blk| (blk["exercises"] || []).size }
  end
end