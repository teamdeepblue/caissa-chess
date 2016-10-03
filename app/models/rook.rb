class Rook < Piece
  def valid_move?(x_destination, y_destination)
    # check for Piece valid_move? conditions
    return false unless super(x_destination, y_destination)
    x_diff_val = diff(x_destination, x_position)
    y_diff_val = diff(y_destination, y_position)
    # return false if King tries moving more than 1 square in any direction
    return false if x_diff_val > 0 && y_diff_val > 0
    true
  end
end