class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :player

  def is_obstructed?(x_destination, y_destination)
    @x_destination = x_destination
    @y_destination = y_destination

    if moving_horizontally?
      return Piece.where(game_id: game.id, y_position: y_position, x_position: (x_position + 1..x_destination - 1)).exists?
    elsif moving_vertically?
      return Piece.where(game_id: game.id, x_position: x_position, y_position: (y_position + 1..y_destination - 1)).exists?
    elsif moving_diagonally? # needs word
      (x_position + 1..x_destination - 1).each do |x|
        y = x - x_position + y_position
        return Piece.where(x_position: x, y_position: y)
      end
    end
  end

  def moving_horizontally?
    y_position == @y_destination
  end

  def moving_vertically?
    x_position == @x_destination
  end

  def moving_diagonally?
    (x_position - @x_destination == y_position - @y_destination)
  end
end
