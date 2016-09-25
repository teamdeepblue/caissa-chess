class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  before_create :validate_max_pieces
  enum piece_name: [:king_black, :king_white, :queen_black, :queen_white, :rook_black, :rook_white, :bishop_black, :bishop_white, :knight_black, :knight_white, :pawn_black, :pawn_white]
  validates :x_position, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 8 }, allow_nil: false
  validates :y_position, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 8 }

  def validate_max_pieces
    errors[:base] << 'Only 32 pieces are allowed.' if Piece.count == 32
    errors.empty?
  end
end
