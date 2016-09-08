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
      post :create, game: {name: 'test game name'}
      expect(response).to redirect_to game_path
      game = Game.last
      expect(game.name).to eq('test game name')
    end
  end
end
