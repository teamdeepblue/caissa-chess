require 'rails_helper'

RSpec.describe Piece, type: :model do
  before do
    @piece = Piece.new(x_position: 3, y_position: 3)
  end

  describe '.valid_move?' do
    it 'should return false if destination coords == current coords' do
      expect(@piece.valid_move?(3, 3)).to eq false
    end

    it 'should return false if destination coords are off the board' do
      expect(@piece.valid_move?(3, 9)).to eq false
    end

    it 'should return true if move is valid' do
      expect(@piece.valid_move?(2, 0)).to eq true
    end
  end

  describe '.diff' do
    it 'should return a positive value' do
      expect(@piece.diff(0, @piece.x_position)).to eq 3
    end
  end
end
