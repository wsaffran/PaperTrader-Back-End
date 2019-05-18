class AddBalanceToGamePlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :game_players, :cash_balance, :integer
  end
end
