class SavedWorkout < ApplicationRecord
  belongs_to :user
  belongs_to :workout

  # optional validation to prevent duplicates at the model level:
  validates :user_id, uniqueness: { scope: :workout_id }
end
