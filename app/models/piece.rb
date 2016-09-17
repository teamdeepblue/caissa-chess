class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :player

  def obstructing_pieces(x_destination, y_destination)
    x_start = x_position
    y_start = y_position
    @x_destination = x_destination
    @y_destination = y_destination
    pieces = []

    if moving_horizontally?
      pieces = Piece.where(game_id: game.id, y_position: y_start, x_position: (x_start + 1..x_destination - 1)).exists?
    elsif moving_vertically?
      pieces = Piece.where(game_id: game.id, x_position: x_start, y_position: (y_start + 1..y_destination - 1)).exists?
    elsif moving_diagonally?    # needs word
      (x_start + 1..x_destination - 1).each do |x|
        y = x - x_start + y_start
        pieces.concat(Piece.where(x_position: x, y_position: y))
      end
    end
  end

  def is_obstructed?(x_destination, y_destination)
    obstructing_pieces(x_destination, y_destination).exists?
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

