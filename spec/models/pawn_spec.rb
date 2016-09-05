require 'rails_helper'

RSpec.describe Pawn, type: :model do
  it 'has a valid Factory' do
    build(:pawn).expect be_valid
  end
end
