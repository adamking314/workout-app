class User < ApplicationRecord
  has_secure_password

  # e.g. validations:
  validates :username, presence: true, uniqueness: true
end
