class CreateAuthors < ActiveRecord::Migration[7.1]
  def change
    create_table :authors do |t|
      t.string :name
      t.date :birthdate
      t.date :death_date
      t.string :url_image

      t.timestamps
    end
  end
end
