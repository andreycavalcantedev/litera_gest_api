class AddUserIdFromAddresses < ActiveRecord::Migration[7.1]
  def change
    add_reference :addresses, :user, foreign_key: true
  end
end
