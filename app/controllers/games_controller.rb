class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show]

  def index
    @games = Game.joins(:players).group('games.id').having('count(players.id) = ?', 1).order(created_at: :desc)
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    @game.players.create(user: current_user, color: [:black, :white].sample)
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find_by_id(params[:id])
    return render text: 'Game Not Found', status: :not_found if @game.blank?
  end

  def get_pieces
    @game = Game.find_by_id(params[:game_id])
    return render text: 'Game Not Found', status: :not_found if @game.blank?
    respond_to do |format|
    format.json { render json: Piece.where(game_id: @game.id) }
    end   
  end

  def current_board
    render json: Piece.where(game_id: @game.id)
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end

end
