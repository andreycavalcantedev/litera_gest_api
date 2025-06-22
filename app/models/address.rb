class Address < ApplicationRecord
  has_one :user
  belongs_to :library, optional: true
end
