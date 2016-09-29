require 'rails_helper'
require 'capybara/rails'

RSpec.describe Devise::SessionsController, type: :controller do	 
  render_views

  before do
  	request.env["devise.mapping"] = Devise.mappings[:user]
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

    it "can sign in user with facebook account" do
	    visit '/'
	    expect(page).to have_link("Sign in with Facebook")
		OmniAuth.config.add_mock(:facebook, {:uid => '12345'})
	    click_link "Sign in with Facebook"
	   # page.to have_content("mockuser")  # user name
	#    page.should have_css('img', :src => 'mock_user_thumbnail_url') # user image
	    expect(page).to have_content("Sign out")
	  end

	  it "can handle authentication error" do
	    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
	    visit '/'
	    expect(page).to have_link("Sign in with Facebook")
	    click_link "Sign in with Facebook"
	    expect(page).to have_content('Sign in')
	  end

	  it "sets a session variable to the OmniAuth auth hash" do
    	request.env["omniauth.auth"][:uid].to eq('12345')
  	  end
end
