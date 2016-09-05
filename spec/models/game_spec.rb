require 'rails_helper'

RSpec.describe Game, type: :model do
  it 'has a valid Factory' do
    build(:game).expect be_valid
  end
end
