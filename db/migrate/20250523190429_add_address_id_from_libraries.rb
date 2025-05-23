class AddAddressIdFromLibraries < ActiveRecord::Migration[7.1]
  def change
    add_reference :libraries, :address, foreign_key: true
  end
end
