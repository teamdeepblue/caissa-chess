require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, :type => :controller do

  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'Facebook' do

    context 'Success handling' do

      before(:each) do
        request.env['omniauth.auth'] = FactoryGirl.create(:auth_hash, :facebook)
        get :facebook
      end

      let(:user) { User.find_by(email: 'testuser@facebook.com') }

      it 'should set :notice flash' do
        expect(flash[:notice]).to be_present
      end

      it 'should set current_user to proper user' do
        expect(subject.current_user).to eq(user)
      end

    end

#    OmniAuth.config.mock_auth[:facebook] = nil

    context 'Non-persisting User' do

      before(:each) do
        request.env['omniauth.auth'] = FactoryGirl.create(
            :auth_hash, :facebook, :does_not_persist
        )
        get :facebook
      end

      it 'should redirect to new user registration' do
        expect(response).to redirect_to new_user_registration_path
      end

      it 'should set flash :notice' do
        expect(flash[:notice]).to be_present
      end

    end

  end
  describe 'Failure' do

    after(:each) do
      Rails.application.reload_routes!
    end

    before(:each) do
      Rails.application.routes.draw do
        devise_scope :user do
          get '/users/auth/failure' => 'omniauth_callbacks#failure'
        end
        root 'home#index'
      end
      get :failure
    end

    it 'should redirect to root path' do
      expect(response).to redirect_to root_path
    end

    it 'should set flash :alert' do
      expect(flash[:alert]).to be_present
    end

  end
end