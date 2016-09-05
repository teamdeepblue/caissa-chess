require 'rails_helper'

RSpec.describe Piece, type: :model do
  it 'has a valid Factory' do
    build(:piece).expect be_valid
  end
end
