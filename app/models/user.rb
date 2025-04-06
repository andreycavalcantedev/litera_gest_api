class User < ApplicationRecord
  belongs_to :library, class_name: 'Library', foreign_key: library_id
end
