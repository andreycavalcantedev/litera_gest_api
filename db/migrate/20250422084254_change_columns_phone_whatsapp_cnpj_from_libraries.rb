class ChangeColumnsPhoneWhatsappCnpjFromLibraries < ActiveRecord::Migration[7.1]
  def change
    change_column :libraries, :phone, :string
    change_column :libraries, :whatsapp, :string
    change_column :libraries, :cnpj, :string
  end
end
