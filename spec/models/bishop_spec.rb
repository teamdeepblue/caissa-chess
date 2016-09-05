require 'rails_helper'

RSpec.describe Bishop, type: :model do
  it 'has a valid Factory' do
    build(:bishop).expect be_valid
  end
end
