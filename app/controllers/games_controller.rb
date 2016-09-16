class GamesController < ApplicationController
  before_action :authenticate_user!

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    @game.players.create(game_id: @game.id, user_id: current_user.id, color: [:black, :white].sample)
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end
end
