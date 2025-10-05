class CreateCodeBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :code_books do |t|
      t.references :book, null: false, foreign_key: true
      t.string :book_code 
      
      t.timestamps
    end
  end
end
