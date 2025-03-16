class CreateTypeUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :type_users do |t|
      t.string :type

      t.timestamps
    end
  end
end
