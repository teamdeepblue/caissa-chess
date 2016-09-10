class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :player

  def is_obstructed?(x_destination, y_destination)
    x_start = self.x_position
    y_start = self.y_position
    pieces = []
    if y_start == y_destination #horizontal case
      x_start < x_destination ? (x_start = x_start + 1) : (x_start = x_start - 1)
      pieces = Piece.where(y_position: y_start, x_position: y_start..x_destination)
    elsif x_start == x_destination #vertical case
      y_start < y_destination ? (y_start = y_start + 1) : (y_start = y_start - 1)
      pieces = Piece.where(x_position: x_start, y_position: y_start..y_destination)      
    elsif x_start - x_destination == y_start - y_destination #slope move
      x_start < x_destination ? (x_start = x_start + 1) : (x_start = x_start - 1)
      (x_start..x_destination).each do |x|
        y = x - x_start + y_start
        pieces.concat(Piece.where(x_position: x, y_position: y))
      end
    else #invalid move
      raise 'This is not a valid move'
    end

    return pieces.length > 0
  end
end
