class GamesController < ApplicationController

  def index
    games = Game.all

    render json: games, each_serializer: GameSerializer
  end

  def new_game
    game = Game.create(name: params[:name], starting_balance: params[:startingBalance], start_date: params[:startDate], end_date: params[:endDate])

    render json: game
  end

end
