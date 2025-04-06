class Library < ApplicationRecord
  has_many :users, class_name: 'User', foreign_key: 'library_id', dependent: :nullify
end
