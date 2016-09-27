class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :player

  def is_obstructed?(x_destination, y_destination)
    pieces = []
    x = x_position
    y = y_position

    if moving_horizontally?(x_destination, y_destination)
      x = (x_position + 1..x_destination - 1)
    elsif moving_vertically?(x_destination, y_destination)
      y = (y_position + 1..y_destination - 1)
    elsif moving_diagonally?(x_destination, y_destination)
      (x_position + 1..x_destination - 1).each do |x|
        y = x - x_position + y_position
        pieces.concat(Piece.where(x_position: x, y_position: y))
      end
      return pieces.length > 0
    end
    return Piece.where(game_id: game.id, y_position: y, x_position: x).exists?

  end

  def moving_horizontally?(x_destination, y_destination)
    y_position == y_destination
  end

  def moving_vertically?(x_destination, y_destination)
    x_position == x_destination
  end

  def moving_diagonally?(x_destination, y_destination)
    (x_position - x_destination == y_position - y_destination)
  end
end
