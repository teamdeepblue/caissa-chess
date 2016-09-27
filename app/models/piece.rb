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

  # returns absolute value of destination coord - current coord
  def diff(destination, current)
    (destination - current).abs
  end
end
