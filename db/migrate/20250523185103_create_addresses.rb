class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :country, null: false
      t.string :state, null: false
      t.string :city, null: false
      t.string :zipcode, null: false
      t.string :district, null: false
      t.string :street, null: false
      t.string :number, null: false
      t.string :complement

      t.timestamps
    end
  end
end
