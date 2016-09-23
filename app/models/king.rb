class King < Piece
  def valid_move?(x_destination, y_destination)
    # check for Piece valid_move? conditions
    return false if super(x_destination, y_destination) == false
    x_diff_val = x_diff(x_destination)
    y_diff_val = y_diff(y_destination)
    # return false if King tries moving more than 1 square in any direction
    return false if x_diff_val > 1 || y_diff_val > 1
    true
  end
end
