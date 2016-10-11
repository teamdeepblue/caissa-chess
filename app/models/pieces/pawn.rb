class Pawn < Piece
  # rubocop: disable AbcSize, CyclomaticComplexity, MethodLength, PerceivedComplexity
  def valid_move?(x_destination, y_destination)
    # check for Piece valid_move? conditions
    return false unless super(x_destination, y_destination)
    diff_x = diff(x_destination, x_position)
    diff_y = diff(y_destination, y_position)
    # a pawn can never move horizontally or, and never move more than two fields ahead, or more than one sideways
    return false if moving_horizontally?(y_destination) || diff_x > 1 || diff_y > 2
    # a pawn cannot move backwards
    return false if player.color == 'white' ? y_destination <= y_position : y_destination >= y_position
    # a pawn can only move 2 squares forward from its starting position
    return false if diff_y == 2 && y_position != (player.color == 'white' ? 1 : 6)
    if diff_x.zero?
      # if the pawn moves straight forward, the destination field cannot contain a piece
      !Piece.where(game_id: game.id, y_position: y_destination, x_position: x_destination).exists?
    else
      # a pawn can only move diagonally if the destination field contains a piece of the opposite player
      Piece.where(game_id: game.id, y_position: y_destination, x_position: x_destination).where.not(player_id: player.id).exists?
      # to do: take into account en passant
    end
  end
  # rubocop: enable all
end
