class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password_digest, length: { minimum: 6 }

  belongs_to :library

  scope :by_library, ->(library_id) { where(library_id: library_id) }
end
