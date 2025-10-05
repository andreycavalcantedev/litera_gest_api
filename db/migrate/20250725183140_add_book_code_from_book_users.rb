class AddBookCodeFromBookUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :book_users, :book_code, :string
  end
end
