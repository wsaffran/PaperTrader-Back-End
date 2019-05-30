class TransactionsController < ApplicationController

  def index
    transactions = Transaction.all

    render json: transactions
  end

  # def update
  #   transaction = Transaction.find(params[:id])
  #   transaction.update(current_shares: params[:current_shares])
  #
  #   render json: transaction
  # end
  #
  # def create
  #   transaction = Transaction.create(game_player_id: params[:game_player_id], symbol: params[:symbol], price: params[:price], current_shares: params[:current_shares], original_shares: params[:original_shares], transaction_date: params[:transaction_date])
  #
  #   render json: transaction
  # end





  def buy
    transaction = Transaction.create(game_player_id: params[:game_player_id], symbol: params[:symbol], price: params[:price], current_shares: params[:current_shares], original_shares: params[:original_shares], transaction_date: params[:transaction_date])
    game_player = GamePlayer.find_by(id: params[:game_player_id])
    cash_balance = game_player.cash_balance
    cash_balance -= params[:price] * params[:current_shares].to_i
    game_player.update(cash_balance: cash_balance)
    render json: transaction
  end

  def sell
    transaction = Transaction.create(game_player_id: params[:game_player_id], symbol: params[:symbol], price: params[:price], current_shares: params[:current_shares], original_shares: params[:original_shares], transaction_date: params[:transaction_date])
    buy_orders = Transaction.select {|transaction| transaction.current_shares > 0 && transaction.symbol === params[:symbol] && transaction.game_player_id === params[:game_player_id]}
    buy_orders.sort_by {|order| order.transaction_date}
    shares_to_be_sold = -transaction.original_shares
    cash_to_add = 0

    buy_orders.each do |order|
      if order.current_shares >= shares_to_be_sold
        new_shares = order.current_shares - shares_to_be_sold
        selected_transaction = Transaction.find_by_id(order.id)
        selected_transaction.update(current_shares: new_shares)
        cash_to_add += params[:price] * shares_to_be_sold
        shares_to_be_sold = 0
      elsif order.current_shares < shares_to_be_sold
        cash_to_add += order.current_shares * params[:price]
        shares_to_be_sold -= order.current_shares
        selected_transaction = Transaction.find_by_id(order.id)
        selected_transaction.update(current_shares: 0)
      end
    end

    game_player = GamePlayer.find_by(id: params[:game_player_id])
    new_balance = game_player.cash_balance + cash_to_add
    game_player.update(cash_balance: new_balance)

    render json: transaction
  end

  def stats
    game = Game.find_by(id: params[:game_id])

    game_players = GamePlayer.select { |player| player.game_id == game.id}
    # game_players = game.game_players

    max = 0
    highest_transactions_player = ''

    game_players.each do |player|
      transactions = Transaction.all.select {|t| t.game_player_id == player.id}
      transaction_count = transactions.length
      if (transaction_count > max)
        highest_transactions_player = User.all.find{|user| user.id == player.user_id}
      end
    end

    render json: highest_transactions_player
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
