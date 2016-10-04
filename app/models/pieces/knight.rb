class Knight < Piece
  def valid_move?(x_destination, y_destination)
    # check for Piece valid_move? conditions
    return false unless super(x_destination, y_destination, true)
    x_diff = diff(x_destination, x_position)
    y_diff = diff(y_destination, y_position)
    # return true if move is 1 horiz/2 vertical OR 2 horiz/1 vertical
    (x_diff == 1 && y_diff == 2) || (x_diff == 2 && y_diff == 1)
  end
end
