class AddLibraryCodeFromUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :accession_number, :string
    add_index :users, :accession_number, unique: true
  end
end
