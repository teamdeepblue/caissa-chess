class PiecesController < ApplicationController
  def new
    @game = Game.find_by_id(params[:game_id]) 
    set_white_pieces
    set_black_pieces
    render json: Piece.all
  end

  private

  def set_white_pieces
    white_pieces = %w(Rook Knight Bishop King Queen Bishop Knight Rook)
    player = Player.where(['color = ? and game_id = ?', 'White', @game.id])
    white_x_pos = 0
    white_pieces.each do |wp|
      Piece.create(player_id: player.ids[0], type: wp, x_position: white_x_pos, y_position: 0)
      Piece.create(player_id: player.ids[0], type: 'Pawn', x_position: white_x_pos, y_position: 1)
      white_x_pos += 1
    end
  end

  def set_black_pieces
    black_pieces = %w(Rook Knight Bishop Queen King Bishop Knight Rook)
    player = Player.where(['color = ? and game_id = ?', 'Black', @game.id])
    black_x_pos = 0
    black_pieces.each do |bp|
      Piece.create(player_id: player.ids[0], type: bp, x_position: black_x_pos, y_position: 7)
      Piece.create(player_id: player.ids[0], type: 'Pawn', x_position: black_x_pos, y_position: 6)
      black_x_pos += 1
    end
  end

  def current_player
    @current_player ||= Player.find(params[:player_id])
  end
end
