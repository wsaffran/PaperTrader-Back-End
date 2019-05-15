class GamePlayersController < ApplicationController

  def index
    game_players = GamePlayer.all

    render json: game_players, each_serializer: GamePlayerSerializer
  end

  def join_game
    game_player = GamePlayer.create(user_id: params[:user_id], game_id: params[:game_id])

    render json: game_player
  end

end
