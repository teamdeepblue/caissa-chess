require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
	def authed_user
    	user = FactoryGirl.create(:user)
    	sign_in user
  	end
	describe "pieces#new action" do
		#before do
		#	@piece = create(:piece)
		#end
		it "Should successfully show the new page" do
#			expect(last_piece.piece).to eq(piece)
	 		game1 = FactoryGirl.create(:game)
			player1 = FactoryGirl.create(:player)
#	      	piece1 = FactoryGirl.create(:piece, player_id: player1.id, game_id: game1.id)
#	      	piece2 = FactoryGirl.create(:piece, player_id: player1.id, game_id: game1.id)
#	      	piece3 = FactoryGirl.create(:piece, player_id: player1.id, game_id: game1.id)
	      	get :new, game_id: game1.id, player_id: player1.id
			expect(response).to have_http_status(:success)
	#	      	expect(assigns(:games, :players)).to eq([game1])
	      	response_value = ActiveSupport::JSON.decode(@response.body)
	      	expect(response_value.count).to eq(32)
#	        response_ids = response_value.collect do |piece| 
#	          piece["id"]
 #       	end
  #      	expect(response_ids).to eq([piece1.id, piece2.id, piece3.id])
		end
	end
end
