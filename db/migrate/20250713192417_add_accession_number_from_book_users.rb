class AddAccessionNumberFromBookUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :book_users, :accession_number, :string
  end
end
