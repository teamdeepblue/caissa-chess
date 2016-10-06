# rubocop:disable all
class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  # stores active pieces to exclude captured pieces
  scope :active, -> { where(captured: false) }

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
        pieces.concat(Piece.active.where(game_id: game.id, x_position: x, y_position: y))
      end
      return !pieces.empty?
    end
    Piece.active.where(game_id: game.id, y_position: y, x_position: x).exists?
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
  # returns false if the destination is occupied and the moving piece and
  # destination piece player_id's are the same
  def valid_move?(x_destination, y_destination)
    return false if x_destination == x_position && y_destination == y_position
    return false if !(0..7).cover?(x_destination) || !(0..7).cover?(y_destination)
    return false if game.occupied?(x_destination, y_destination) && game.find_piece(x_destination, y_destination).player_id == self.player_id
    true
  end

  # returns absolute value of destination coord - current coord
  def diff(destination, current)
    (destination - current).abs
  end

  # checks for valid move
  # initiates capture of opponent's piece if true
  # updates the poaition of the capturing piece
  def move_to!(x_destination, y_destination)
    return false unless valid_move?(x_destination, y_destination)
    capture_piece(x_destination, y_destination)
    self.update_attributes(x_position: x_destination, y_position: y_destination)
  end

  def capture_piece(x_destination, y_destination)
    return false unless game.occupied?(x_destination, y_destination)
    self.game.find_piece(x_destination, y_destination).captured!
    return true
  end

  # updates database if captured
  def captured!
    self.update_attributes(captured: true)
  end
end
