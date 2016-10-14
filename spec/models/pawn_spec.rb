require 'rails_helper'

RSpec.describe Pawn, type: :model do
  it_behaves_like 'Piece'

  let(:game) { FactoryGirl.create(:game) }
  let(:white) { FactoryGirl.create(:player, color: 'white', game: game) }
  let(:black) { FactoryGirl.create(:player, color: 'black', game: game) }
  let(:white_pawn) { FactoryGirl.create(:pawn, player: white, y_position: 1, x_position: 4, game: game) }
  let(:black_pawn) { FactoryGirl.create(:pawn, player: black, y_position: 6, x_position: 4, game: game) }

  # non-capturing moves
  it 'should return true if move is 1 spot vertical forward' do
    expect(white_pawn.valid_move?(4, 2)).to eq true
    expect(black_pawn.valid_move?(4, 5)).to eq true
  end

  it 'should return true if move is 1 spot vertical forward with other piece present' do
    FactoryGirl.create(:piece, game: game, x_position: 4, y_position: 2)
    FactoryGirl.create(:piece, game: game, x_position: 4, y_position: 5)
    expect(white_pawn.valid_move?(4, 2)).to eq false
    expect(black_pawn.valid_move?(4, 5)).to eq false
  end

  it 'should return false if move is 1 spot vertical backward' do
    expect(white_pawn.valid_move?(4, 0)).to eq false
    expect(black_pawn.valid_move?(4, 6)).to eq false
  end

  it 'should return false if move is 1 spot horizontal' do
    expect(black_pawn.valid_move?(3, 6)).to eq false
  end

  it 'should return false if move is 3 spots vertical' do
    expect(black_pawn.valid_move?(4, 3)).to eq false
    expect(white_pawn.valid_move?(4, 4)).to eq false
  end

  it 'should return true if move is 2 spots vertical from starting position' do
    expect(white_pawn.valid_move?(4, 3)).to eq true
    expect(black_pawn.valid_move?(4, 4)).to eq true
  end

  it 'should return false if move is 1 spot diagonally forward without a piece present' do
    expect(white_pawn.valid_move?(3, 2)).to eq false
    expect(black_pawn.valid_move?(3, 5)).to eq false
  end

  it 'should return false if move is 2 spots vertical from any other position' do
    white_pawn.y_position = 2
    black_pawn.y_position = 5
    expect(white_pawn.valid_move?(4, 4)).to eq false
    expect(black_pawn.valid_move?(4, 3)).to eq false
  end

  it 'should return false if move is 1 spot diagonally backward' do
    expect(white_pawn.valid_move?(3, 0)).to eq false
    expect(black_pawn.valid_move?(3, 7)).to eq false
  end

  # capturing moves
  it 'should return true if move is 1 spot diagonally forward with opposite piece present' do
    FactoryGirl.create(:pawn, player: white, game: game, x_position: 3, y_position: 5)
    FactoryGirl.create(:pawn, player: black, game: game, x_position: 3, y_position: 2)
    expect(white_pawn.valid_move?(3, 2)).to eq true
    expect(black_pawn.valid_move?(3, 5)).to eq true
  end

  it 'should return false if move is 2 spot diagonally forward with opposite piece present' do
    FactoryGirl.create(:pawn, player: white, game: game, x_position: 3, y_position: 4)
    FactoryGirl.create(:pawn, player: black, game: game, x_position: 3, y_position: 3)
    expect(white_pawn.valid_move?(3, 3)).to eq false
    expect(black_pawn.valid_move?(3, 4)).to eq false
  end

  it 'should return false if move is 1 spot diagonally forward with own piece present' do
    FactoryGirl.create(:pawn, player: black, game: game, x_position: 3, y_position: 5)
    FactoryGirl.create(:pawn, player: white, game: game, x_position: 3, y_position: 2)
    expect(white_pawn.valid_move?(3, 2)).to eq false
    expect(black_pawn.valid_move?(3, 5)).to eq false
  end
end
