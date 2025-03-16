class RenameTypeColumnInTypeUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :type_users, :type, :role
  end
end
