class ChangeCardIdentityToStringFromUsers < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :card_identity, :string
  end
end
