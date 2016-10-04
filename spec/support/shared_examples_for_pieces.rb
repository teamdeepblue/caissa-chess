require 'spec_helper'

shared_examples 'Piece' do
  it 'should have attribute type' do
    expect(subject).to have_attribute :type
  end

  it 'should initialize successfully as an instance of the described class' do
    expect(subject).to be_a_kind_of Piece
  end
end
