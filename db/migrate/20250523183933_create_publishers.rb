class CreatePublishers < ActiveRecord::Migration[7.1]
  def change
    create_table :publishers do |t|
      t.string :name
      t.string :cnpj
      t.string :phone
      t.string :email
      t.string :url

      t.timestamps
    end
  end
end
