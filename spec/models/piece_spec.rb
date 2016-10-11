require 'rails_helper'

RSpec.describe Piece, type: :model do
  before do
    Piece.create(game_id: game.id, player_id: 1, x_position: 5, y_position: 0)
    Piece.create(game_id: game.id, x_position: 0, y_position: 6)
  end
  it_behaves_like 'Piece'

  let(:game) { create :game }
  let(:piece) { Piece.create(game_id: game.id, player_id: 1, x_position: 0, y_position: 0) }
  let(:other_piece) { Piece.create(game_id: game.id, player_id: 2, x_position: 4, y_position: 4) }

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

    it 'should return false if destination is occupied and player ids are the same' do
      expect(piece.valid_move?(5, 0)).to eq false
    end

    it 'should return true if destination is occupied and player ids are not the same' do
      expect(piece.valid_move?(4, 4)).to eq true
    end

    describe '.diff' do
      it 'should return a positive value' do
        expect(piece.diff(3, piece.x_position)).to eq 3
      end
    end
  end

  describe '.move_to!' do
    let(:game) { create :game }
    let(:piece) { Piece.create(game_id: game.id, player_id: 1, x_position: 0, y_position: 0) }
    let(:other_piece) { Piece.create(game_id: game.id, player_id: 2, x_position: 0, y_position: 4) }

    it 'should validate that moving pieces x,y values are updated' do
      expect(piece.move_to!(0, 1)).to eq true
      expect(piece.x_position).to eq 0
      expect(piece.y_position).to eq 1
    end

    it 'should not move the piece if the move is invalid' do
      x_position = piece.x_position
      y_position = piece.y_position
      expect(piece.move_to!(1, 5)).to eq false
      expect(piece.x_position).to eq x_position
      expect(piece.y_position).to eq y_position
    end

    it 'should mark a captured piece as captured' do
      expect(piece.move_to!(0, 4)).to eq true
      expect(piece.x_position).to eq 0
      expect(piece.y_position).to eq 4
      other_piece.reload
      expect(other_piece.captured!).to eq true
    end
  end
end
