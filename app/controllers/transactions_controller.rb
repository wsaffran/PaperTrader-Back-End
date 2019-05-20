class TransactionsController < ApplicationController

  def index
    transactions = Transaction.all

    render json: transactions
  end

  def create
    transaction = Transaction.create(game_player_id: params[:game_player_id], symbol: params[:symbol], price: params[:price], shares: params[:shares], transaction_date: params[:transaction_date])

    render json: transaction
  end

end
