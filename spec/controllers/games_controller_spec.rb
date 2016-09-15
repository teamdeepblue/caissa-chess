require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  describe 'games#index action' do
    it "should succesfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'should give an overview of games with only one player' do
      game1 = FactoryGirl.create(:game)
      game2 = FactoryGirl.create(:game)
      game3 = FactoryGirl.create(:game)
      player1 = FactoryGirl.create(:player, game_id: game1.id)
      player2 = FactoryGirl.create(:player, game_id: game2.id)
      player3 = FactoryGirl.create(:player, game_id: game2.id)
      get :index
      expect(assigns(:games)).to eq([game1]) 
      #game 2 already 2 players, game 3 has no players (should not be possible in normal flow)
      #so only game one should be shown
    end
  end

end
