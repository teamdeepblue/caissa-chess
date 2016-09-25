class PiecesController < ApplicationController
	def new
		white_pieces = ["rook_white", "knight_white", "bishop_white", "king_white", "queen_white", "bishop_white", "knight_white", "rook_white"]
  		black_pieces = ["rook_black", "knight_black", "bishop_black", "queen_black", "king_black", "bishop_black", "knight_black", "rook_black"]
  		white_x_pos = 1
  		for wp in white_pieces
  			Piece.create(piece_name: wp, x_position: white_x_pos, y_position: 1)
  			white_x_pos += 1
  		end
  		black_x_pos = 1
  		for bp in black_pieces
  			Piece.create(piece_name: bp, x_position: black_x_pos, y_position: 8)
  			black_x_pos += 1
  		end
  		pawn_pos = 1
  		8.times do
  			Piece.create(piece_name: "pawn_white", x_position: pawn_pos, y_position: 2)
  			Piece.create(piece_name: "pawn_black", x_position: pawn_pos, y_position: 7)
  			pawn_pos += 1
  		end
  		render json: Piece.all
	end
end
