class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :player

  def is_obstructed?(x_destination, y_destination)
    x_start = self.x_position
    y_start = self.y_position
    if y_start == y_destination #horizontal case
      pieces = Piece.where(y_position: y_start, x_position: x_start..x_destination)
    elsif x_start == x_destination #vertical case
      # ...
    elsif x_start - x_destination == y_start - y_destination #slope move
      # ...
    else #invalid move
      # ...
    end
  end
end
