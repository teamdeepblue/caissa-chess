# rubocop:disable all
class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  # stores active pieces to exclude captured pieces
  scope :active, -> { where(captured: false) }

  before_create :validate_max_pieces
  validates :x_position, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 7 }, allow_nil: false
  validates :y_position, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 7 }

  def validate_max_pieces
    errors[:base] << 'Only 32 pieces are allowed per game.' if ((Piece.count).fdiv(Game.count)) >= 32
    errors.empty?
  end

  def obstructed?(x_destination, y_destination)
    pieces = []
    x = x_position
    y = y_position
    if moving_horizontally?(y_destination)
      return false unless diff(x_destination, x_position) > 1
      direction_start_x = x_destination <=> x_position
      x_start = x_position + direction_start_x
      x_end = x_destination - (diff(x_destination, x_position) > 1 ? direction_start_x : 0)
      x = x_start < x_end ? x_start..x_end : x_end..x_start
    elsif moving_vertically?(x_destination)
      return false unless diff(y_destination, y_position) > 1
      direction_start_y = y_destination <=> y_position
      y_start = y_position + direction_start_y
      y_end = y_destination - (diff(y_destination, y_position) > 1 ? direction_start_y : 0)
      y = y_start < y_end ? y_start..y_end : y_end..y_start
    elsif moving_diagonally?(x_destination, y_destination)
      return false unless diff(x_destination, x_position) + diff(y_destination, y_position) > 2
      direction_start_x = x_destination <=> x_position
      x_start = x_position + direction_start_x
      x_end = x_destination - (diff(x_destination, x_position) > 1 ? direction_start_x : 0)
      direction_start_y = direction_start_x * (y_destination <=> y_position)
      x = x_start < x_end ? x_start..x_end : x_end..x_start
      x.each do |x_temp|
        y_temp = direction_start_y * (x_temp - x_position) + y_position
        pieces.concat(Piece.where(game_id: game.id, x_position: x_temp, y_position: y_temp))
      end
      return !pieces.empty?
    end
    Piece.active.where(game_id: game.id, y_position: y, x_position: x).exists?
  end

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
  # returns false if the destination is occupied and the moving piece and destination piece player_id's are the same
  # then (unless piece is a knight) determines if the piece is obstructed
  def valid_move?(x_destination, y_destination, knight = false)
    return false if x_destination == x_position && y_destination == y_position
    return false if !(0..7).cover?(x_destination) || !(0..7).cover?(y_destination)
    return false if game.occupied?(x_destination, y_destination) && game.find_piece(x_destination, y_destination).player_id == player_id
    return true if knight
    !obstructed?(x_destination, y_destination)
  end

  # rubocop:enable all

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
    update_attributes(x_position: x_destination, y_position: y_destination)
  end

  def capture_piece(x_destination, y_destination)
    return false unless game.occupied?(x_destination, y_destination)
    game.find_piece(x_destination, y_destination).captured!
    true
  end

  # updates database if captured
  def captured!
    update_attributes(captured: true)
  end
end
