class PiecesController < ApplicationController
  before_action :authenticate_user!, only: [:update]
  def new
    @game = Game.find_by_id(params[:game_id])
    set_white_pieces
    set_black_pieces
    render json: Piece.where(game_id: @game.id)
  end

  def update
    @game = Game.find_by_id(params[:game_id])
    @piece = @game.pieces.find_by_id(params[:id])
    x_destination = piece_params([:x_position])
    y_destination = piece_params([:y_position])
    (flash[:error] = "Not a valid move") unless @piece.move_to!(x_destination, y_destination)
    redirect_to game_path(@game)
  end

  private

  def piece_params
    params.require(:piece).permit(:x_position, :y_position)
  end

  def set_white_pieces
    white_pieces = %w(Rook Knight Bishop King Queen Bishop Knight Rook)
    player = Player.where(['color = ? and game_id = ?', :white, @game.id])
    white_x_pos = 0
    white_pieces.each do |wp|
      Piece.create(game_id: @game.id, player_id: player.ids[0], type: wp, x_position: white_x_pos, y_position: 0)
      Piece.create(game_id: @game.id, player_id: player.ids[0], type: 'Pawn', x_position: white_x_pos, y_position: 1)
      white_x_pos += 1
    end
  end

  def set_black_pieces
    black_pieces = %w(Rook Knight Bishop Queen King Bishop Knight Rook)
    player = Player.where(['color = ? and game_id = ?', :black, @game.id])
    black_x_pos = 0
    black_pieces.each do |bp|
      Piece.create(game_id: @game.id, player_id: player.ids[0], type: bp, x_position: black_x_pos, y_position: 7)
      Piece.create(game_id: @game.id, player_id: player.ids[0], type: 'Pawn', x_position: black_x_pos, y_position: 6)
      black_x_pos += 1
    end
  end
end
