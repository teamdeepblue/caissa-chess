class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :player

  def obstructed?(x_dest, y_dest)
    pieces = []
    x = x_position
    y = y_position

    if moving_horizontally?(x_dest, y_dest)
      x = (x_position + 1..x_dest - 1)
    elsif moving_vertically?(x_dest, y_dest)
      y = (y_position + 1..y_dest - 1)
    elsif moving_diagonally?(x_dest, y_dest)
      (x_position + 1..x_dest - 1).each do |x|
        y = x - x_position + y_position
        pieces.concat(Piece.where(x_position: x, y_position: y))
      end
      return !pieces.empty?
    end
    Piece.where(game_id: game.id, y_position: y, x_position: x).exists?
  end

  def moving_horizontally?(x_dest, y_dest)
    y_position == y_dest
  end

  def moving_vertically?(x_dest, _y_dest)
    x_position == x_dest
  end

  def moving_diagonally?(x_dest, y_dest)
    (x_position - x_dest == y_position - y_dest)
  end
end
