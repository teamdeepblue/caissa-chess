require 'rails_helper'

RSpec.describe Piece, type: :model do
  before do
    Piece.create(game_id: game.id, x_position: 5, y_position: 0)
    Piece.create(game_id: game.id, x_position: 0, y_position: 6)
    Piece.create(game_id: game.id, x_position: 4, y_position: 4)
  end
  let(:game) { create(:game) }
  let(:piece) { Piece.create(game_id: game.id, x_position: 0, y_position: 0) }

  describe '.obstructed?' do

    it 'should detect an obstructing piece horizontally' do
      expect(piece.obstructed?(7, 0)).to be true
    end

    it 'should not detect an obstructing piece horizontally' do
      expect(piece.obstructed?(3, 0)).to be false
    end

    it 'should detect an obstructing piece vertically' do
      expect(piece.obstructed?(0, 7)).to be true
    end

    it 'should not detect an obstructing piece vertically' do
      expect(piece.obstructed?(0, 5)).to be false
    end

    it 'should detect an obstructing piece diagonally' do
      expect(piece.obstructed?(7, 7)).to be true
    end

    it 'should not detect an obstructing piece diagonally' do
      expect(piece.obstructed?(2, 2)).to be false
    end
  end

  describe '.valid_move?' do
    it 'should return false if destination coords == current coords' do
      expect(piece.valid_move?(0, 0)).to eq false
    end

    it 'should return false if destination coords are off the board' do
      expect(piece.valid_move?(3, 9)).to eq false
    end

    it 'should return true if move is generally valid' do
      expect(piece.valid_move?(2, 0)).to eq true
    end
  end

  describe '.diff' do
    it 'should return a positive value' do
      expect(piece.diff(3, piece.x_position)).to eq 3
    end
  end

  describe '.move_to!' do
    it 'should move the piece to the destination square' do
      expect(piece.move_to!(2, 6)).to be true
    end

    it 'return false if the move is valid' do
      expect(piece.valid_move?(4, 7)).to eq false
    end
  end

  describe '.capture_piece' do
    it 'returns false is the destination is occupied' do
      expect(piece.is_occupied?(2, 6)).to eq false
    end
  end
end
