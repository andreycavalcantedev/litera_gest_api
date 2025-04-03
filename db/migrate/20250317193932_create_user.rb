class CreateUser < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :cpf
      t.integer :card_identity
      t.references :type_user, null: false, foreign_key: true
      t.string :password

      t.timestamps
    end
  end
end
