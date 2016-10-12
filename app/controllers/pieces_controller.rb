class PiecesController < ApplicationController
  def new
    @game = Game.find_by_id(params[:game_id])
    set_white_pieces
    set_black_pieces
    render json: Piece.where(game_id: @game.id)
  end

  private

  def set_white_pieces
    white_pieces = %w(Rook Knight Bishop King Queen Bishop Knight Rook)
    player = Player.where(['color = ? and game_id = ?', "white", @game.id])
    white_x_pos = 0
    white_pieces.each do |wp|
      Piece.create(game_id: @game.id, player_id: player.ids[0], type: wp, x_position: white_x_pos, y_position: 0)
      Piece.create(game_id: @game.id, player_id: player.ids[0], type: 'Pawn', x_position: white_x_pos, y_position: 1)
      white_x_pos += 1
    end
  end

  def set_black_pieces
    black_pieces = %w(Rook Knight Bishop Queen King Bishop Knight Rook)
    player = Player.where(['color = ? and game_id = ?', "black", @game.id])
    black_x_pos = 0
    black_pieces.each do |bp|
      Piece.create(game_id: @game.id, player_id: player.ids[0], type: bp, x_position: black_x_pos, y_position: 7)
      Piece.create(game_id: @game.id, player_id: player.ids[0], type: 'Pawn', x_position: black_x_pos, y_position: 6)
      black_x_pos += 1
    end
  end
end
