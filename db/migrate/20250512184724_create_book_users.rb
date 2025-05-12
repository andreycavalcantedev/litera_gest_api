class CreateBookUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :book_users do |t|
      t.references :book, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :date_reservation
      t.datetime :date_devolution

      t.timestamps
    end
  end
end
