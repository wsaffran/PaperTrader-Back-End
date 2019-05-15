class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :symbol, :price, :shares, :transaction_date 
end
