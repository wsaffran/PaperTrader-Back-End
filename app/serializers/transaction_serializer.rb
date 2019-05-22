class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :symbol, :price, :current_shares, :original_shares, :transaction_date

  belongs_to :game_player, serializer: GamePlayerSerializer
  # has_one :game, :through => :game_player

end
