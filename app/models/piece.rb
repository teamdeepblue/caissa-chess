class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :player

  # return false if attempting to move to current square
  # then determines if the destination square is within the board boundaries
  def valid_move?(x_destination, y_destination)
    return false if x_destination == x_position && y_destination == y_position
    return false if !(0..7).cover?(x_destination) || !(0..7).cover?(y_destination)
    true
  end

  # returns absolute value of destination x - current x
  def x_diff(x_destination)
    (x_destination - x_position).abs
  end

  # returns absolute value of destination y - current y
  def y_diff(y_destination)
    (y_destination - y_position).abs
  end
end
