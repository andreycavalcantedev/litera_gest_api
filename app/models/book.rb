class Book < ApplicationRecord
  belongs_to :author, optional: true
  belongs_to :publisher, optional: true

  scope :by_library, ->(library_id) { where(library_id: library_id) }
end
