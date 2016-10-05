require 'rails_helper'

RSpec.describe King, type: :model do
  it_behaves_like 'Piece'

  let(:game) { create :game }
  let(:king) { King.create(game_id: game.id, x_position: 3, y_position: 3) }

  describe '.valid_move?' do
    it 'should return true if move is 1 spot horizontal' do
      expect(king.valid_move?(4, 3)).to eq true
    end

    it 'should return true if move is 1 spot vertical' do
      expect(king.valid_move?(3, 2)).to eq true
    end

    it 'should return true if move is 1 spot diagonal' do
      expect(king.valid_move?(4, 4)).to eq true
    end

    it 'should return false if move is 1 spot left, 2 up' do
      expect(king.valid_move?(2, 1)).to eq false
    end

    it 'should return false if move is 3 spots left, 2 down' do
      expect(king.valid_move?(0, 5)).to eq false
    end
  end
end
