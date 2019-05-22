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

end
