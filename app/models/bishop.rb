class Bishop < Piece
  def valid_move?(x_destination, y_destination)
    return false unless super(x_destination, y_destination)
    return false if obstructed?(x_destination, y_destination)
    x_diff_val = diff(x_destination, x_position)
    y_diff_val = diff(y_destination, y_position)
    return true if x_diff_val == y_diff_val
    false
  end
end
