require 'rails_helper'

RSpec.describe Queen, type: :model do
  it 'has a valid Factory' do
    build(:queen).expect be_valid
  end
end
