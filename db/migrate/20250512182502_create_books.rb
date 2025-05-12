class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|

      t.string :title
      t.string :description
      t.string :year_published
      t.string :gender
      t.string :isbn
      t.integer :total_quantity
      t.integer :quantity

      t.timestamps
    end
  end
end
