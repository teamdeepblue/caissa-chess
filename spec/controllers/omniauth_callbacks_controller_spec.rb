require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller  do
  describe 'Facebook OmniAuth tests' do
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
    end

    describe "Facebook login" do
      it "should successfully create a user" do
        post :facebook
        expect(:user_id).to_not be_nil
      end

      # it "should successfully create a session/logged in user" do
      # end
    end
  end
  
end
