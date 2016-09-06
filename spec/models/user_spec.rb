require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid Factory' do
    build(:user).expect be_valid
  end
end
