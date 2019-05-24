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

  # def create
  #
  #   if params[:type_of_transaction] == "buy"
  #     transaction = Transaction.create(game_player_id: params[:game_player_id], symbol: params[:symbol], price: params[:price], current_shares: params[:shares], original_shares: params[:shares], transaction_date: params[:transaction_date])
  #   elsif params[:type_of_transaction] == "sell"
  #     transaction = Transaction.create(game_player_id: params[:game_player_id], symbol: params[:symbol], price: params[:price], current_shares: 0, original_shares: -params[:shares], transaction_date: params[:transaction_date])
  #
  #     # Update the current shares
  #     sold_stock_symbol = params[:symbol]
  #     sold_stock_price = params[:price]
  #     sold_stock_shares = params[:shares]
  #
  #     current_game_player = GamePlayer.find_by(id: params[:game_player_id])
  #     transactions = Transaction.select { |transaction| transaction.game_player_id === current_game_player.id}
  #
  #     relevant_transactions = transactions.select do |transaction|
  #       transaction.symbol == sold_stock_symbol && transaction.current_shares > 0
  #     end
  #
  #     relevant_transactions.sort {|a, b| a.transaction_date <=> b.transaction_date}
  #
  #     shares_to_be_sold = sold_stock_shares
  #     cash_to_add = 0
  #
  #     byebug
  #     relevant_transactions.each do |relevant_transaction|
  #       if shares_to_be_sold >= 1
  #
  #         if relevant_transaction.current_shares >= shares_to_be_sold
  #           shares = relevant_transaction.current_shares - shares_to_be_sold
  #           cash_to_add += (shares_to_be_sold * sold_stock_price) - (shares_to_be_sold * relevant_transaction.price)
  #           shares_to_be_sold = 0
  #
  #
  #           # transaction_to_update = Transaction.find_by(id: relevant_transaction.id)
  #           # transaction_to_update = Transaction.update(current_shares: shares)
  #         end
  #       end
  #     end
  #
  #
  #   end
  #
  #
  #
  #
  #   # transaction = Transaction.create(game_player_id: params[:game_player_id], symbol: params[:symbol], price: params[:price], current_shares: params[:current_shares], original_shares: params[:original_shares], transaction_date: params[:transaction_date])
  #
  #   render json: transaction
  # end


end
