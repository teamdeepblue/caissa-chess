# rubocop:disable all
class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :player

  def obstructed?(x_destination, y_destination)
    pieces = []
    x = x_position
    y = y_position

    if moving_horizontally?(y_destination)
      x = (x_position + 1..x_destination - 1)
    elsif moving_vertically?(x_destination)
      y = (y_position + 1..y_destination - 1)
    elsif moving_diagonally?(x_destination, y_destination)
      (x_position + 1..x_destination - 1).each do |x_temp|
        y = x_temp - x_position + y_position
        pieces.concat(Piece.where(game_id: game.id, x_position: x, y_position: y))
      end
      return !pieces.empty?
    end
    Piece.where(game_id: game.id, y_position: y, x_position: x).exists?
  end

# rubocop:enable all

  def moving_horizontally?(y_destination)
    y_position == y_destination
  end

  def moving_vertically?(x_destination)
    x_position == x_destination
  end

  def moving_diagonally?(x_destination, y_destination)
    (x_position - x_destination == y_position - y_destination)
  end

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
