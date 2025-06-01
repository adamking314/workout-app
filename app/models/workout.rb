class Workout < ApplicationRecord
  # If you want to enforce that the username exists in users, you could add a custom validation:
  # validate :username_must_exist

  # def username_must_exist
  #   unless User.exists?(username: username)
  #     errors.add(:username, "must refer to a valid user")
  #   end
  # end

  validates :username, presence: true
  validates :workout_name, presence: true
  # add more validations as required
end
