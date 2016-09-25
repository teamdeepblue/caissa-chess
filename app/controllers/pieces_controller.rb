class PiecesController < ApplicationController
  def new
    set_white_pieces
    set_black_pieces
    pawn_pos = 1
    8.times do
      Piece.create(piece_name: 'pawn_white', x_position: pawn_pos, y_position: 2)
      Piece.create(piece_name: 'pawn_black', x_position: pawn_pos, y_position: 7)
      pawn_pos += 1
    end
    render json: Piece.all
  end

  private

  def set_white_pieces
    white_pieces = %w(rook_white knight_white bishop_white king_white queen_white bishop_white knight_white rook_white)
    white_x_pos = 1
    white_pieces.each do |wp|
      Piece.create(piece_name: wp, x_position: white_x_pos, y_position: 1)
      white_x_pos += 1
    end
  end

  def set_black_pieces
    black_pieces = %w(rook_black knight_black bishop_black queen_black king_black bishop_black knight_black rook_black)
    black_x_pos = 1
    black_pieces.each do |bp|
      Piece.create(piece_name: bp, x_position: black_x_pos, y_position: 8)
      black_x_pos += 1
    end
  end
end
