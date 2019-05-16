class GameSerializer < ActiveModel::Serializer
  attributes :id, :name, :starting_balance, :start_date, :end_date #, :players

  has_many :game_players
  has_many :users, through: :game_players
  #
  # def players
  #   self.object.game_players do |player|
  #     {id: player.id}
  #   end
  # end
end
