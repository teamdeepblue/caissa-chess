require 'rails_helper'
require 'capybara/rails'

RSpec.describe Devise::SessionsController, type: :controller do	 
  render_views

  before do
  	request.env["devise.mapping"] = Devise.mappings[:user]
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end
end
