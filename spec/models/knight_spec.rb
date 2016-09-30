require 'rails_helper'

RSpec.describe Knight, type: :model do
  let(:game) { create :game }
  let(:knight) { Knight.create(game_id: game.id, x_position: 3, y_position: 3) }

  describe '.valid_move?' do
    context 'piece is not obstructed' do
      it 'returns true if move is 1 up, 2 east' do
        expect(knight.valid_move?(5, 2)).to eq true
      end

      it 'returns true if move is 2 down, 1 west' do
        expect(knight.valid_move?(2, 5)).to eq true
      end

      it 'returns true if move is 2 west, 1 up' do
        expect(knight.valid_move?(1, 2)).to eq true
      end

      it 'returns true if move is 1 east, 2 down' do
        expect(knight.valid_move?(4, 5)).to eq true
      end

      it 'returns false if move is a true diagonal' do
        expect(knight.valid_move?(5, 1)).to eq false
      end

      it 'returns false if move is horizontal' do
        expect(knight.valid_move?(7, 3)).to eq false
      end

      it 'returns false if move is vertical' do
        expect(knight.valid_move?(3, 7)).to eq false
      end

      it 'returns false if move is to the same square' do
        expect(knight.valid_move?(3, 3)).to eq false
      end
    end
  end

  describe '.valid_move?' do
    context 'piece technically has obstructions' do
      before do
        Piece.create(game_id: game.id, x_position: 4, y_position: 2)
        Piece.create(game_id: game.id, x_position: 4, y_position: 3)
        Piece.create(game_id: game.id, x_position: 3, y_position: 4)
        Piece.create(game_id: game.id, x_position: 2, y_position: 4)
      end

      it 'returns true if move is 1 up, 2 east' do
        expect(knight.valid_move?(5, 2)).to eq true
      end

      it 'returns true if move is 2 down, 1 west' do
        expect(knight.valid_move?(2, 5)).to eq true
      end
    end
  end
end
