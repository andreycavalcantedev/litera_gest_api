class Book < ApplicationRecord
  belongs_to :author, optional: true
  belongs_to :publisher, optional: true

  has_many :book_users, dependent: :destroy
  has_many :users, through: :book_users

  scope :by_library, ->(library_id) { where(library_id: library_id) }
  scope :search_by_title, ->(title) {
    where(
      title.split.map {"title ILIKE ?"}.join(" AND "),
      *title.split.map { |name| "%#{name}%" }
    )
  }
  scope :search_by_author, ->(author) {
    joins(:author).where(
      author.split.map {"authors.name ILIKE ?"}.join(" AND "),
      *author.split.map { |name| "%#{name}%" }
    )
  }
  scope :search_by_publisher, ->(publisher) {
    joins(:publisher).where(
      publisher.split.map {"publishers.name ILIKE ?"}.join("  AND "),
      *publisher.split.map { |name| "%#{name}%" }
    )
  }
end
