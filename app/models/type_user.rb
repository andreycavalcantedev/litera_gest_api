class TypeUser < ApplicationRecord
  has_many :users, class_name: 'User', foreign_key: 'type_user_id', dependent: :nullify
end
