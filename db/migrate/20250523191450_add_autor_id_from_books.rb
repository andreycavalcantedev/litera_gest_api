class AddAutorIdFromBooks < ActiveRecord::Migration[7.1]
  def change
    add_reference :books, :author, foreign_key: true
  end
end
