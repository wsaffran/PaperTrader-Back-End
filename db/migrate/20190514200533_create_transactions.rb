class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :game_player_id
      t.string :symbol
      t.integer :price
      t.integer :shares
      t.date :transaction_date

      t.timestamps
    end
  end
end
