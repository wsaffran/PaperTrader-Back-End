class RemoveColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :game_players, :transaction_id
  end
end
