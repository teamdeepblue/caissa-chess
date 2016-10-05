# rubocop:disable all
class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :player

  def obstructed?(x_destination, y_destination)
    pieces = []
    x = x_position
    y = y_position
    if moving_horizontally?(y_destination)
      direction_start = x_destination <=> x_position
      x_start = x_position + direction_start
      x_end = x_destination - (diff(x_destination, x_position) > 1 ? direction_start : 0)
      x = x_start < x_end ? x_start..x_end : x_end..x_start
    elsif moving_vertically?(x_destination)
      direction_start = y_destination <=> y_position
      y_start = y_position + direction_start
      y_end = y_destination - (diff(y_destination, y_position) > 1 ? direction_start : 0)
      y = y_start < y_end ? y_start..y_end : y_end..y_start
    elsif moving_diagonally?(x_destination, y_destination)
      direction_start_x = x_destination <=> x_position
      x_start = x_position + direction_start_x
      x_end = x_destination - (diff(x_destination, x_position) > 1 ? direction_start_x : 0)
      direction_start_y = direction_start_x * (y_destination <=> y_position)
      x = x_start < x_end ? x_start..x_end : x_end..x_start
      # byebug
      x.each do |x_temp|
        y_temp = direction_start_y * (x_temp - x_position) + y_position
        # byebug
        pieces.concat(Piece.where(game_id: game.id, x_position: x_temp, y_position: y_temp))
      end
      # byebug
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
    ((x_position - x_destination).abs == (y_position - y_destination).abs)
  end

  # return false if attempting to move to current square
  # then determines if the destination square is within the board boundaries
  # then determines if the piece is obstructed
  def valid_move?(x_destination, y_destination)
    return false if x_destination == x_position && y_destination == y_position
    return false if !(0..7).cover?(x_destination) || !(0..7).cover?(y_destination)
    !obstructed?(x_destination, y_destination)
  end

  # returns absolute value of destination coord - current coord
  def diff(destination, current)
    (destination - current).abs
  end
end
