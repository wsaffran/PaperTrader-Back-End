class GamePlayerSerializer < ActiveModel::Serializer
  attributes :id, :transactions

  belongs_to :game
  belongs_to :user
  has_many :transactions, serializer: TransactionSerializer

  def transactions
    self.object.transactions.map do |transaction|
      {id: transaction.id}
    end
  end

  # def game
  #   self.object.game do |game|
  #     {name: game.name}
  #   end
  # end

end
