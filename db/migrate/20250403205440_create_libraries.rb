class CreateLibraries < ActiveRecord::Migration[7.1]
  def change
    create_table :libraries do |t|
      t.string :name
      t.integer :phone
      t.integer :whatsapp
      t.string :email
      t.time :opening_time
      t.time :closing_time
      t.integer :cnpj
      t.string :instagram

      t.timestamps
    end
  end
end
