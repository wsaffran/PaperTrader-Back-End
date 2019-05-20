class Transaction < ApplicationRecord

  belongs_to :game_player
  # has_one :game, :through => :game_player

end
