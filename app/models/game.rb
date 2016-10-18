class Game < ActiveRecord::Base
  has_many :pieces
  has_many :players

  # returns an occupying piece or nil
  def occupied?(x_destination, y_destination)
    pieces.active.where(y_position: y_destination, x_position: x_destination).any?
  end

  # returns the piece to be captured
  def find_piece(x_destination, y_destination)
    pieces.active.where(x_position: x_destination, y_position: y_destination).first
  end
end
