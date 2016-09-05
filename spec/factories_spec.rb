FactoryGirl.factories.map(&:name).each do |factory_name|
  describe "The #{factory_name} factory" do
     it 'is valid' do
      build(factory_name).expect be_valid
     end
  end
end
