class GamePlayersController < ApplicationController

  def index
    game_players = GamePlayer.all

    render json: game_players, each_serializer: GamePlayerSerializer
  end

  def show
    game_player = GamePlayer.find(params[:id])

    render json: game_player
  end

  def update
    game_player = GamePlayer.find(params[:id])
    game_player.update(cash_balance: (game_player.cash_balance + params[:cash_to_add]))

    render json: game_player
  end

  def join_game
    game_player = GamePlayer.create(user_id: params[:user_id], game_id: params[:game_id], cash_balance: params[:cash_balance])

    render json: game_player
  end

  def portfolio
    transactions = Transaction.select {|transaction| transaction.game_player_id == params[:game_player_id].to_i}
    distinct_tickers = transactions.map {|transaction| transaction.symbol}.uniq

    transactions.sort_by {|transaction| transaction.symbol}

    url = URI.parse("https://api.iextrading.com/1.0/stock/market/batch?symbols=#{distinct_tickers.join(',')}&types=quote")
    code = Net::HTTP.get_response(url).body
    stock_data = JSON.parse(code)

    new_array = []

    distinct_tickers.each do |ticker|
      total_cost = 0
      total_shares = 0
      total_price_before = 0
      total_price_after = 0
      transactions.each do |transaction|
        if transaction.symbol == ticker
          total_shares += transaction.current_shares
          total_cost += transaction.price * transaction.current_shares
        end
      end
      transactions.each do |transaction|
        if transaction.symbol == ticker
          total_price_before += (total_shares * stock_data[ticker]["quote"]["latestPrice"]) - (total_shares * stock_data[ticker]["quote"]["change"])
          total_price_after += total_shares * stock_data[ticker]["quote"]["latestPrice"]
        end
      end
      day_change_percent = (total_price_after - total_price_before) / total_price_before * 100


      num_game_id = GamePlayer.find_by(id: params[:game_player_id]).game_id
      num_game = Game.find_by(id: num_game_id).id
      num_game_players = GamePlayer.select { |game_player| game_player.game_id == num_game}

      num_holding = 0

      num_game_players.each do |game_player|
        num_distinct_tickers = game_player.transactions.map {|transaction| transaction.symbol}.uniq
        if num_distinct_tickers.include?(ticker)
          num_holding += 1
        end
      end


      if total_shares > 0
        new_array.push({
          :ticker => ticker,
          :total_cost => total_cost,
          :total_shares => total_shares,
          :cost_basis => total_cost / total_shares,
          :current_stock_price => stock_data[ticker]["quote"]["latestPrice"],
          :value_gain => (stock_data[ticker]["quote"]["latestPrice"] * total_shares - total_cost),
          :percent_gain => (((total_shares * stock_data[ticker]["quote"]["latestPrice"]) - total_cost) / total_cost * 100),
          :current_value => total_shares * stock_data[ticker]["quote"]["latestPrice"],
          :stock_day_change => stock_data[ticker]["quote"]["change"],
          :day_change => stock_data[ticker]["quote"]["change"] * total_shares,
          :day_change_percent => day_change_percent,
          :players_holding => num_holding
        })
      end
    end
    new_array.sort_by {|a| a["symbol"]}.reverse

    total_value = 0
    new_array.each do |arr|
      total_value += arr[:current_value]
    end
    game_player = GamePlayer.find_by(id: params[:game_player_id])
    total_cash = game_player.cash_balance

    total_value += total_cash

    new_array.map do |arr|
      arr.merge!(:percent_of_portfolio => arr[:current_value]/total_value)
    end


    render json: new_array
  end

end
