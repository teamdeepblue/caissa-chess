class Pawn < Piece
  def valid_move?(x_destination, y_destination)
    #byebug
    # check for Piece valid_move? conditions
    return false unless super(x_destination, y_destination)
    #byebug
    #a pawn can never move horizontally or, and never move more than two fields ahead, or more than one sideways
    return false if moving_horizontally?(y_destination) || diff(x_destination, x_position) > 1 || diff(y_destination, y_position) > 2
    white_piece = player.color == "white"
    #a pawn can never move backwards
    return false if (white_piece ? y_destination <= y_position : y_destination >= y_position)
    #byebug
    start_point =  white_piece ? 1 : 6
    #byebug
    #a pawn can only move 2squares forward from its starting position
    return false if diff(y_destination, y_position) == 2 && y_position != start_point
    #byebug
    if diff(x_destination, x_position) == 0
      #if the pawn moves straight forward, the destination field cannot contain a piece
      !Piece.where(game_id: game.id, y_position: y_destination, x_position: x_destination).exists?
    else
      #byebug
      #a pawn can only move diagonally if the destination field contains a piece of the opposite player
      Piece.where(game_id: game.id, y_position: y_destination, x_position: x_destination).where.not(player_id: player.id).exists?
      #to do: take into account en passant
      #byebug
    end
  end
end
