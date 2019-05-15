class ChangeTable < ActiveRecord::Migration[5.2]
  def change
    rename_column :game_players, :player_id, :user_id
  end
end
