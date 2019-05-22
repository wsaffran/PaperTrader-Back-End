class TransactionsController < ApplicationController

  def index
    transactions = Transaction.all

    render json: transactions
  end

  def update

    transaction = Transaction.find(params[:id])
    transaction.update(current_shares: params[:current_shares])

    
    render json: transaction
  end

  def create
    transaction = Transaction.create(game_player_id: params[:game_player_id], symbol: params[:symbol], price: params[:price], current_shares: params[:current_shares], original_shares: params[:original_shares], transaction_date: params[:transaction_date])

    render json: transaction
  end

end
