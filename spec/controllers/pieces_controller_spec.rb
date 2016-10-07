require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
  describe 'pieces#new action' do
    it 'Should successfully show the new page' do
      game1 = FactoryGirl.create(:game)
      game2 = FactoryGirl.create(:game)
      player1 = FactoryGirl.create(:player)
      player2 = FactoryGirl.create(:player)
      get :new, game_id: game1.id, player_id: player1.id
      expect(response).to have_http_status(:success)
      response_value = ActiveSupport::JSON.decode(@response.body)
      expect(response_value.count).to eq(32)
      get :new, game_id: game2.id, player_id: player2.id
      expect(response).to have_http_status(:success)
      response_value = ActiveSupport::JSON.decode(@response.body)
      expect(response_value.count).to eq(32)
      expect(Piece.count).to eq(64)
    end

    context 'with invalid status' do
      Game.delete_all
      game3 = FactoryGirl.create(:game)
      player3 = FactoryGirl.create(:player)
      let(:piece) { FactoryGirl.create(:piece, player_id: player3.id, game_id: game3.id) }
      it 'Raises an exception when more than 32 pieces are created' do
        get :new, game_id: game3.id, player_id: player3.id
        expect { piece.validate_max_pieces }.to raise_exception(ActiveRecord::RecordNotSaved)
      end
    end
  end
end
