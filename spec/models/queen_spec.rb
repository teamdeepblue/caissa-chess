require 'rails_helper'

RSpec.describe Queen, type: :model do
  it_behaves_like 'Piece'

  let(:game) { create :game }
  let(:queen) { Queen.create(game_id: game.id, x_position: 3, y_position: 3) }

  describe '.valid_move?' do
    context 'piece is not obstructed' do
      it 'returns true if move is horizontal east' do
        expect(queen.valid_move?(6, 3)).to eq true
      end

      it 'returns true if move is horizontal west' do
        expect(queen.valid_move?(0, 3)).to eq true
      end

      it 'returns true if move vertical north' do
        expect(queen.valid_move?(3, 0)).to eq true
      end

      it 'returns true if move is vertical south' do
        expect(queen.valid_move?(3, 7)).to eq true
      end

      it 'returns true if move is a true diagonal to NE' do
        expect(queen.valid_move?(6, 0)).to eq true
      end

      it 'returns true if move is a true diagonal to NW' do
        expect(queen.valid_move?(1, 1)).to eq true
      end

      it 'returns true if move is a true diagonal to SE' do
        expect(queen.valid_move?(6, 6)).to eq true
      end

      it 'returns true if move is a true diagonal to SW' do
        expect(queen.valid_move?(0, 6)).to eq true
      end

      it 'returns false if move is 1 north, 3 east' do
        expect(queen.valid_move?(6, 2)).to eq false
      end

      it 'returns false if move is 2 south, 1 west' do
        expect(queen.valid_move?(2, 5)).to eq false
      end

      it 'returns false if move is to the same square' do
        expect(queen.valid_move?(3, 3)).to eq false
      end
    end
  end

  describe '.valid_move?' do
    context 'piece IS obstructed' do
      before do
        Piece.create(game_id: game.id, x_position: 4, y_position: 2)
        Piece.create(game_id: game.id, x_position: 4, y_position: 3)
        Piece.create(game_id: game.id, x_position: 4, y_position: 4)
        Piece.create(game_id: game.id, x_position: 3, y_position: 4)
        Piece.create(game_id: game.id, x_position: 2, y_position: 4)
        Piece.create(game_id: game.id, x_position: 2, y_position: 3)
        Piece.create(game_id: game.id, x_position: 2, y_position: 2)
        Piece.create(game_id: game.id, x_position: 3, y_position: 2)
      end

      it 'returns false on a blocked move to horizontal east' do
        expect(queen.valid_move?(6, 3)).to eq false
      end

      it 'returns false on a blocked move to horizontal west' do
        expect(queen.valid_move?(0, 3)).to eq false
      end

      it 'returns false on a blocked move to vertical north' do
        expect(queen.valid_move?(3, 0)).to eq false
      end

      it 'returns false on a blocked move to vertical south' do
        expect(queen.valid_move?(3, 7)).to eq false
      end

      it 'returns false on a blocked move to NE true diagonal' do
        expect(queen.valid_move?(6, 0)).to eq false
      end

      it 'returns false on a blocked move to NW true diagonal' do
        expect(queen.valid_move?(1, 1)).to eq false
      end

      it 'returns false on a blocked move to SE true diagonal' do
        expect(queen.valid_move?(6, 6)).to eq false
      end

      it 'returns false on a blocked move to SW true diagonal' do
        expect(queen.valid_move?(0, 6)).to eq false
      end
    end
  end
end
