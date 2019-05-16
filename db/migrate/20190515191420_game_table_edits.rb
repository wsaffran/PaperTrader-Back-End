class GameTableEdits < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :num_of_players, :integer
  end
end
