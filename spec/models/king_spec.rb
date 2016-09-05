require 'rails_helper'

RSpec.describe King, type: :model do
  it 'has a valid Factory' do
    build(:king).expect be_valid
  end
end
