require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  # sign-in a user
  def authed_user
    user = FactoryGirl.create(:user)
    sign_in user
  end

  describe 'games#new action' do
    it 'should successfully show the New Game form page - if user is logged in' do
      authed_user
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'should require users to be logged in to view New Game form page' do
      get :new
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'games#create action' do
    it 'should successfully create a new game in the database - if user is logged in' do
      authed_user
      post :create, game: { name: 'test game name' }
      expect(response).to redirect_to game_path(assigns(:game))
      game = Game.last
      expect(game.name).to eq('test game name')
    end

    it 'should require users to be logged in to create a new game' do
      post :create, game: { name: 'test game name' }
      expect(response).to redirect_to new_user_session_path
    end

    it 'should successfully create a Player and assign them to the logged in user' do
      user = FactoryGirl.create(:user)
      sign_in user
      post :create, game: { name: 'test game name' }
      player = Player.last
      expect(player.user_id).to eq user.id
    end

    it 'should successfully create a Player and assign them to a game' do
      authed_user
      post :create, game: { name: 'test game name' }
      player = Player.last
      game = Game.last
      expect(player.game_id).to eq game.id
    end

    it 'should successfully create a Player and assign them a color' do
      authed_user
      post :create, game: { name: 'test game name' }
      player = Player.last
      expect(player.color).to_not be_nil
    end
  end

  describe 'games#show action' do
    it 'should successfully show the Game Show page - if the game is found & user is logged in' do
      authed_user
      FactoryGirl.create(:game)
      game = Game.last
      get :show, id: game.id
      expect(response).to have_http_status(:success)
    end

    it 'should require users to be logged in to show the Game Show page - if the game is found' do
      FactoryGirl.create(:game)
      game = Game.last
      get :show, id: game.id
      expect(response).to redirect_to new_user_session_path
    end

    it 'should return a 404 error - if the game is NOT found & user is logged in' do
      authed_user
      get :show, id: 'TACOCAT'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'games#index action' do
    it 'should succesfully show the page' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'should give an overview of games with only one player' do
      game1 = FactoryGirl.create(:game)
      game2 = FactoryGirl.create(:game)
      FactoryGirl.create(:player, game_id: game1.id)
      FactoryGirl.create(:player, game_id: game2.id)
      FactoryGirl.create(:player, game_id: game2.id)
      get :index
      expect(assigns(:games)).to eq([game1])
      # game 2 already 2 players, game 3 has no players (should not be possible in normal flow)
      # so only game one should be shown
    end
  end
end
