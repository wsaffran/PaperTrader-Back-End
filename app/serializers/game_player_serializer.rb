class GamePlayerSerializer < ActiveModel::Serializer
  attributes :id, :game, :user, :cash_balance, :transactions

  belongs_to :game, serializer: GameSerializer
  belongs_to :user, serializer: UserSerializer
  has_many :transactions, serializer: TransactionSerializer

  # def transactions
  #   self.object.transactions.map do |transaction|
  #     {id: transaction.id}
  #   end
  # end

  # def game
  #   self.object.game do |game|
  #     {name: game.name}
  #   end
  # end

end
