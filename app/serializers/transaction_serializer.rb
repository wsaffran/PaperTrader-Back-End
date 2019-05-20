class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :symbol, :price, :shares, :transaction_date

  belongs_to :game_player, serializer: GamePlayerSerializer
  # has_one :game, :through => :game_player

end
