require 'rails_helper'

RSpec.describe Piece, type: :model do
  before do
    Piece.create(game_id: game.id, player_id: 1, x_position: 5, y_position: 0)
    Piece.create(game_id: game.id, x_position: 0, y_position: 6)
  end

  let(:game) { create :game }
  let(:piece) { Piece.create(game_id: game.id, x_position: 4, y_position: 4) }

  describe '.occupied?' do
    it 'should return true if the destination is occupied' do
      expect(game.occupied?(5, 0)).to eq true
    end

    it 'should return false if the destination not occupied' do
      expect(game.occupied?(4, 0)).to eq false
    end
  end

  describe '.find_piece' do
    it 'should return a piece if there is one' do
      expect(piece.game.find_piece(4, 4)).to eq piece
    end

    it 'should return nil if there is not one' do
      expect(piece.game.find_piece(4, 5)).to eq nil
    end
  end
end
