require 'rails_helper'

RSpec.describe Knight, type: :model do
  it 'has a valid Factory' do
    build(:knight).expect be_valid
  end
end
