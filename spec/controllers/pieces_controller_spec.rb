require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
	describe "pieces#new action" do
		it "Should successfullt show the new page" do
			piece = Piece.create(
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
