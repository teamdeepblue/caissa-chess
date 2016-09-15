require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe 'games#new action' do
    it 'should successfully show the New Game form page' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'games#create action' do
    it 'should successfully create a new game in the database' do
      post :create, game: { name: 'test game name' }
      expect(response).to redirect_to game_path(assigns(:game))
      game = Game.last
      expect(game.name).to eq('test game name')
    end
  end

  describe 'games#show action' do
    it 'should successfully show the Game Show page - if the game is found' do
      post :create, game: { name: 'test game name' }
      game = Game.last
      get :show, id: game.id
      expect(response).to have_http_status(:success)
    end
  end

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
