require 'rails_helper'

RSpec.describe Player, type: :model do
  it 'has a valid Factory' do
    build(:player).expect be_valid
  end
end
