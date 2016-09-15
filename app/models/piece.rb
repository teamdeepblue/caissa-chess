class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :player

  def is_obstructed?(x_destination, y_destination)
    x_start = x_position
    y_start = y_position
    @x_destination = x_destination
    @y_destination = y_destination

    if moving_horizontally?
      x_start = x_position + 1
      x_end = x_destination - 1
      return Piece.where(game_id: game.id, y_position: y_start, x_position: (x_start..x_destination)).exists?
    elsif moving_vertically?
      y_start = y_position + 1
      y_end = y_destination - 1
      return Piece.where(game_id: game.id, x_position: x_start, y_position: (y_start..y_end)).exists?
    elsif moving_diagonally?    # needs word
      x_start = x_position + 1
      x_end = x_destination - 1
      (x_start..x_destination).each do |x|
        y = x_destination - x_start + y_start
      end
      return Piece.where(game_id: game.id, y_position: y_start, x_position: (x_start..x_destination)).exists?
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

