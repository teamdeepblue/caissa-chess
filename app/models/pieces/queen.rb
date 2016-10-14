class Queen < Piece
  def valid_move?(x_destination, y_destination)
    # check for Piece valid_move? conditions
    return false unless super(x_destination, y_destination)
    # check that Queen is moving only horizontal, vertical, or in a true diagonal
    moving_horizontally?(y_destination) || moving_vertically?(x_destination) || moving_diagonally?(x_destination, y_destination)
  end
end
