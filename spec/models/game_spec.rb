require 'rails_helper'

RSpec.describe Piece, type: :model do
  before do
    Piece.create(game_id: game.id, player_id: 1, x_position: 5, y_position: 0)
    Piece.create(game_id: game.id, x_position: 0, y_position: 6)
    Piece.create(game_id: game.id, player_id: 2, x_position: 4, y_position: 4)
  end

  describe '.capture_piece' do
    it 'should be able to capture a piece' do
      expect(game.occupied?(2, 6)).to eq false
    end
  end
end
