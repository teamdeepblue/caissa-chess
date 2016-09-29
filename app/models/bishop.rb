class Bishop < Piece
  def valid_move?(x_destination, y_destination)
    # check for Piece valid_move? conditions
    return false unless super(x_destination, y_destination)
    x_diff_val = diff(x_destination, x_position)
    y_diff_val = diff(y_destination, y_position)
    # return true if move is a true diagonal
    x_diff_val == y_diff_val
  end
end
