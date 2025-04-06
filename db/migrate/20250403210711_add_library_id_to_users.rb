class AddLibraryIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :library, foreign_key: true
  end
end
