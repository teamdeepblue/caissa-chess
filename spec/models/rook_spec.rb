require 'rails_helper'

RSpec.describe Rook, type: :model do
  it 'has a valid Factory' do
    build(:rook).expect be_valid
  end
end
