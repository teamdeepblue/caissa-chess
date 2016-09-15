class GamesController < ApplicationController

  def index
    @games = Game.joins(:players).group("games.id").having("count(players.id) = ?",1).order(created_at: :desc)
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
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
