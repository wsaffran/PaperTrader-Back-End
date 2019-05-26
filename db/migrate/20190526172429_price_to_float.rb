class PriceToFloat < ActiveRecord::Migration[5.2]
  def change
    change_column :transactions, :price, :float
    change_column :game_players, :cash_balance, :float
  end
end
