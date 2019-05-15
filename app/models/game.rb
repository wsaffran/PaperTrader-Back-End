class Game < ApplicationRecord
  has_many :game_players #, foreign_key: "user_id"
  # has_many :users, through: :game_players
end
