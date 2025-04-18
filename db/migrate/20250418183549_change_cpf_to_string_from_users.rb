class ChangeCpfToStringFromUsers < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :cpf, :string
  end
end
