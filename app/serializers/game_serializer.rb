class GameSerializer < ActiveModel::Serializer
  attributes :id, :name, :starting_balance, :start_date, :end_date, :game_players, :users

  has_many :game_players, serializer: GamePlayerSerializer
  has_many :users, through: :game_players, serializer: UserSerializer
  #
  # def players
  #   self.object.game_players do |player|
  #     {id: player.id}
  #   end
  # end
end
