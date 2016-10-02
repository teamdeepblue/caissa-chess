require 'rails_helper'

RSpec.describe PlayerController, type: :controller do
	describe "player#create action" do 
		it "should successfully create a new player" do
			g = FactoryGirl.create(:game)
			u = FactoryGirl.create(:user)
			sign_in u

			post :create, game_id: g.id
			#test for redirection to correct path
			expect(g.players.length).to 
		end 
end
