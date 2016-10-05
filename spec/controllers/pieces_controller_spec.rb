require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
	describe "pieces#new action" do
		it "Should successfully show the new page" do
			game = Game.create(name: 'test game')
			piece = Piece.create(
				player_id: 1,
				type: 'Rook',
				x_position: 1,
				y_position: 1
			)
			last_piece = Piece.last
			get :new
			expect(response).to have_http_status(:success)
			expect(last_piece.piece).to eq(piece)
		end
	end
end
