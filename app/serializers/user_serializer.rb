class UserSerializer < ActiveModel::Serializer
  attributes :id, :game_players

  has_many :game_players, serializer: GamePlayerSerializer

  # def game_players
  #   self.object.game_players.map do |gp|
  #     if gp.id == user.id
  #       {id: gp.id}
  #     end
  #   end
  # end

  def transactions
    self.object.transactions.map do |transaction|
      {
      id: transaction.id,
      game_player_id: transaction.game_player_id,
      symbol: transaction.symbol,
      price: transaction.price,
      shares: transaction.shares,
      transaction_date: transaction.transaction_date
      }
    end
  end
end
