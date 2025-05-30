class Address < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :library, optional: true
end
