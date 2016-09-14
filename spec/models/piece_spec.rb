require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe 'is_obstructed? method' do
    it 'should return false for an unobstructed horizontal move right' do
      piece = FactoryGirl.create(:piece, x_position: 0, y_position: 0)
      expect(piece.is_obstructed?(5,0)).to be(false)
    end

    it 'should return false for an unobstructed horizontal move left' do
      piece = FactoryGirl.create(:piece, x_position: 5, y_position: 0)
      expect(piece.is_obstructed?(0,0)).to be(false)
    end

    it 'should return true for an obstructed horizontal move right' do
      piece = FactoryGirl.create(:piece, x_position: 0, y_position: 0)
      piece = FactoryGirl.create(:piece, x_position: 2, y_position: 0)
      piece = FactoryGirl.create(:piece, x_position: 4, y_position: 0)
      expect(piece.is_obstructed?(5,0)).to be(true)
    end

    it 'should return true for an obstructed horizontal move left' do
      piece = FactoryGirl.create(:piece, x_position: 5, y_position: 0)
      piece = FactoryGirl.create(:piece, x_position: 2, y_position: 0)
      piece = FactoryGirl.create(:piece, x_position: 4, y_position: 0)
      expect(piece.is_obstructed?(1,0)).to be(true)
    end

    it 'should return false for an unobstructed vertical move down' do
      piece = FactoryGirl.create(:piece, x_position: 1, y_position: 1)
      expect(piece.is_obstructed?(1,7)).to be(false)
    end

    it 'should return false for an unobstructed vertical move up' do
      piece = FactoryGirl.create(:piece, x_position: 2, y_position: 3)
      expect(piece.is_obstructed?(2,1)).to be(false)
    end

    it 'should return true for an obstructed vertical move up' do
      piece = FactoryGirl.create(:piece, x_position: 0, y_position: 0)
      piece = FactoryGirl.create(:piece, x_position: 0, y_position: 3)
      piece = FactoryGirl.create(:piece, x_position: 0, y_position: 6)
      expect(piece.is_obstructed?(0,7)).to be(true)
    end

    it 'should return true for an obstructed vertical move down' do
      piece = FactoryGirl.create(:piece, x_position: 1, y_position: 6)
      piece = FactoryGirl.create(:piece, x_position: 1, y_position: 5)
      piece = FactoryGirl.create(:piece, x_position: 1, y_position: 1)
      expect(piece.is_obstructed?(1,0)).to be(true)
    end

    it 'should return false for an unobstructed slope move down right' do
      piece = FactoryGirl.create(:piece, x_position: 1, y_position: 1)
      expect(piece.is_obstructed?(4,4)).to be(false)
    end

    it 'should return false for an unobstructed slope move up left' do
      piece = FactoryGirl.create(:piece, x_position: 2, y_position: 3)
      expect(piece.is_obstructed?(0,1)).to be(false)
    end

    it 'should return true for an obstructed slope move down left' do
      piece = FactoryGirl.create(:piece, x_position: 4, y_position: 7)
      piece = FactoryGirl.create(:piece, x_position: 3, y_position: 6)
      expect(piece.is_obstructed?(1,4)).to be(true)
    end

    it 'should return true for an obstructed slope move up right' do
      piece = FactoryGirl.create(:piece, x_position: 5, y_position: 6)
      piece = FactoryGirl.create(:piece, x_position: 3, y_position: 4)
      expect(piece.is_obstructed?(3,4)).to be(true)
    end
  end

end