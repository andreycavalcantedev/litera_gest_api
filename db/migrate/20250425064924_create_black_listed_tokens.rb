class CreateBlackListedTokens < ActiveRecord::Migration[7.1]
  def change
    create_table :black_listed_tokens do |t|
      t.string :token, null: false

      t.timestamps
    end
  end
end
