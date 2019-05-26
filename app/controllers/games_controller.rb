require 'net/http'

class GamesController < ApplicationController

  def index
    games = Game.all

    render json: games, each_serializer: GameSerializer
  end

  def new_game
    game = Game.create(name: params[:name], starting_balance: params[:startingBalance], start_date: params[:startDate], end_date: params[:endDate])

    render json: game
  end

  def rankings
    game = Game.find(params[:id])

    rankings = []

    game = Game.find(params[:id])
    game_players = game.game_players

    # loop through each game_player to get data from each
    game_players.each do |game_player|
      # cash balance
      cash_balance = game_player.cash_balance
      # returns on holdings to add to cash balance
      returns = 0 # GAIN/LOSS VALUE
      # tickers of all stocks held
      stocks = game_player.transactions.map do |transaction|
        transaction.symbol
      end
      stocks.uniq

      # fetch stock data
      url = URI.parse("https://api.iextrading.com/1.0/stock/market/batch?symbols=#{stocks.join(',')}&types=quote")
      code = Net::HTTP.get_response(url ).body
      stock_data = JSON.parse(code)

      # loop through each game_players transactions
      game_player.transactions.each do |transaction|
        returns += (transaction.current_shares * stock_data[transaction.symbol]["quote"]["latestPrice"]) - (transaction.price * transaction.current_shares)
      end


      # returns = current_value - game.starting_balance *** WHY IS THIS NOT WORKING
      current_value = game_player.cash_balance + returns
      returns = current_value - game.starting_balance
      percent_gain = (current_value - game.starting_balance) / game.starting_balance * 100
      trades = game_player.transactions.length

      # totalDayChange(game_player, current_value, stock_data)

      rankings.push({
        game_player_id: game_player.id,
        username: game_player.user.username,
        returns: returns,
        current_value: current_value,
        percent_gain: percent_gain,
        starting_balance: game.starting_balance,
        trades: trades
      })

    end

    new_rankings = rankings.sort { |a,b| a['current_value'] <=> b['current_value']}.reverse

    i = 1

    new_rankings.map do |ranking|
      ranking.merge!(ranking: i)
      i += 1
    end

    render json: new_rankings
  end

end

# def totalDayChange(game_player, current_value, stock_data)
#
#   total_cost = 0
#     game_player.transactions.map(transaction => {
#       return total_cost += transaction.price * transaction.current_shares
#     })
#
#   current_cash_value = game_player.starting_cash - total_cost
#
#   starting = current_cash_value
#   current = current_cash_value
#
#   game_player.transactions.map do |transaction|
#     open_price = stock_data[transaction.symbol]["quote"]["open"]
#     current_price = stock_data[transaction.symbol]["quote"]["latestPrice"]
#
#     starting += transaction.current_shares * open_price
#     current += transaction.current_shares * current_price
#   end
#
#   byebug
# end
