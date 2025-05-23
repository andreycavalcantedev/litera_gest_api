class AddPublisherIdFromBooks < ActiveRecord::Migration[7.1]
  def change
    add_reference :books, :publisher, foreign_key: true
  end
end
