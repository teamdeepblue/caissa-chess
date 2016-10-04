require 'rails_helper'

RSpec.describe Rook, type: :model do
  it_behaves_like 'Piece'

  let(:game) { create :game }
  let(:rook) { Rook.create(game_id: game.id, x_position: 3, y_position: 3) }

  describe '.valid_move?' do
    context 'piece is not obstructed' do
      it 'should return true if move is 3 spots horizontal' do
        expect(rook.valid_move?(6, 3)).to eq true
      end

      it 'should return true if move is 4 spot vertical' do
        expect(rook.valid_move?(3, 7)).to eq true
      end

      it 'should return false if move is 2 spots diagonal' do
        expect(rook.valid_move?(1, 1)).to eq false
      end

      it 'should return false if move is 1 spot left, 2 up' do
        expect(rook.valid_move?(2, 1)).to eq false
      end

      it 'should return false if move is 3 spots left, 2 down' do
        expect(rook.valid_move?(0, 5)).to eq false
      end

      it 'returns false if move is to the same square' do
        expect(rook.valid_move?(3, 3)).to eq false
      end
    end
  end
  describe '.valid_move?' do
    context 'piece IS obstructed' do
      before do
        Piece.create(game_id: game.id, x_position: 4, y_position: 3)
        Piece.create(game_id: game.id, x_position: 3, y_position: 4)
        Piece.create(game_id: game.id, x_position: 2, y_position: 3)
        Piece.create(game_id: game.id, x_position: 3, y_position: 2)
      end

      it 'returns false on a blocked move to the east' do
        expect(rook.valid_move?(5, 3)).to eq false
      end

      it 'returns false on a blocked move to the north' do
        expect(rook.valid_move?(3, 5)).to eq false
      end

      it 'returns false on a blocked move to the west' do
        expect(rook.valid_move?(1, 3)).to eq false
      end

      it 'returns false on a blocked move to the south' do
        expect(rook.valid_move?(3, 1)).to eq false
      end
    end
  end
end
