class User < ApplicationRecord
  has_secure_password

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 30 }

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP }
 # Workouts this user has created (if you set it up that way):
  has_many :created_workouts,
           class_name: "Workout",
           foreign_key: :username,
           primary_key: :username,
           dependent: :destroy 
  # (Above: adjust if your Workout model’s “creator” key is something else.)

  # SavedWorkout join records:
  has_many :saved_workouts, dependent: :destroy
  # Through join, pull actual Workout objects:
  has_many :workouts_bookmarked,
           through: :saved_workouts,
           source: :workout

end

