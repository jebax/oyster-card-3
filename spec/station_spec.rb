require 'station'
describe Station do
  let(:station) { Station.new(:london_bridge, 1) }
it 'should have a name when it is created' do
  expect(station.name).to eq :london_bridge
end

it 'should have a zone numner when it is created' do
  expect(station.zone).to eq 1
end

end
