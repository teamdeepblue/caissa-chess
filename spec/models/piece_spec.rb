require 'rails_helper'

RSpec.describe Piece, type: :model do
  let(:game) {create :game}

  describe 'is_obstructed?' do
    let(:piece) {Piece.create(game_id: game.id, x_position: 0, y_position: 0)}
    before do
      Piece.create(game_id: game.id, x_position: 5, y_position: 0)
      Piece.create(game_id: game.id, x_position: 0, y_position: 6)
      Piece.create(game_id: game.id, x_position: 4, y_position: 4)
    end

    it 'should detect an obstructing piece horizontally' do
      expect(piece.is_obstructed?(7, 0)).to be true
    end

    it 'should not detect an obstructing piece horizontally' do
      expect(piece.is_obstructed?(3, 0)).to be false
    end

    it 'should detect an obstructing piece vertically' do
      expect(piece.is_obstructed?(0, 7)).to be true
    end

    it 'should not detect an obstructing piece vertically' do
      expect(piece.is_obstructed?(0, 5)).to be false
    end

    it 'should detect an obstructing piece diagonally' do
      expect(piece.is_obstructed?(7, 7)).to be true
    end

    it 'should not detect an obstructing piece diagonally' do
      expect(piece.is_obstructed?(2, 2)).to be false
    end
  end
end
