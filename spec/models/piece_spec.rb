require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe 'is_obstructed?' do
    it 'should detect an obstructing piece horizontally' do
      game = Game.create
      piece = Piece.create(game_id: game.id, x_position: 0, y_position: 0)
      Piece.create(game_id: game.id, x_position: 3, y_position: 0)
      Piece.create(game_id: game.id, x_position: 5, y_position: 0)
      expect(piece.is_obstructed?(7, 0)).to be true
    end

    it 'should detect an obstructing piece vertically' do
      game = Game.create
      piece = Piece.create(game_id: game.id, x_position: 0, y_position: 0)
      Piece.create(game_id: game.id, x_position: 0, y_position: 2)
      Piece.create(game_id: game.id, x_position: 0, y_position: 6)
      expect(piece.is_obstructed?(0, 7)).to be true
    end

    it 'should detect an obstructing piece diagonally' do
      game = Game.create
      piece = Piece.create(game_id: game.id, x_position: 0, y_position: 0)
      Piece.create(game_id: game.id, x_position: 0, y_position: 0)
      Piece.create(game_id: game.id, x_position: 4, y_position: 4)
      expect(piece.is_obstructed?(7, 7)).to be true
    end
  end
end
