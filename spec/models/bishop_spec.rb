require 'rails_helper'

RSpec.describe Bishop, type: :model do
  it_behaves_like 'Piece'
  let(:game) { create :game }
  let(:bishop) { Bishop.create(game_id: game.id, x_position: 3, y_position: 3) }

  describe '.valid_move?' do
    context 'piece is not obstructed' do
      it 'returns true if move is a true diagonal to the northeast' do
        expect(bishop.valid_move?(6, 0)).to eq true
      end

      it 'returns true if move is a true diagonal to the southeast' do
        expect(bishop.valid_move?(7, 7)).to eq true
      end

      it 'returns true if move is a true diagonal to the southwest' do
        expect(bishop.valid_move?(1, 5)).to eq true
      end

      it 'returns true if move is a true diagonal to the northwest' do
        expect(bishop.valid_move?(2, 2)).to eq true
      end

      it 'returns false if move is not a true diagonal (x_diff != y_diff)' do
        expect(bishop.valid_move?(6, 1)).to eq false
      end

      it 'returns false if move is horizontal' do
        expect(bishop.valid_move?(6, 3)).to eq false
      end

      it 'returns false if move is vertical' do
        expect(bishop.valid_move?(3, 0)).to eq false
      end

      it 'returns false if move is to the same square' do
        expect(bishop.valid_move?(3, 3)).to eq false
      end
    end
  end

  describe '.valid_move?' do
    context 'piece IS obstructed' do
      before do
        Piece.create(game_id: game.id, x_position: 5, y_position: 1)
        Piece.create(game_id: game.id, x_position: 6, y_position: 6)
        Piece.create(game_id: game.id, x_position: 2, y_position: 4)
        Piece.create(game_id: game.id, x_position: 2, y_position: 2)
      end

      it 'returns false on a true diagonal to the northeast' do
        expect(bishop.valid_move?(6, 0)).to eq false
      end

      it 'returns false on a true diagonal to the southeast' do
        expect(bishop.valid_move?(7, 7)).to eq false
      end

      it 'returns false on a true diagonal to the southwest' do
        expect(bishop.valid_move?(1, 5)).to eq false
      end

      it 'returns false on a true diagonal to the northwest' do
        expect(bishop.valid_move?(0, 0)).to eq false
      end
    end
  end
end
