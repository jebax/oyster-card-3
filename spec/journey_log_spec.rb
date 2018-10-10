require 'journey_log'

describe JourneyLog do
  let(:station) { double(:station, name: :aldgate, zone: 1) }
  let(:station_2)  { double(:station_2, name: :brixton, zone: 2) }
  let(:journey) { double(:journey, start: nil, finish: nil, data: {entry: station, exit: station_2}) }
  let(:journey_class) { double(:journey_class, new: journey) }
  let(:journey_log) { JourneyLog.new(journey_class) }

  describe "#initialize" do
    it 'should start with an empty journeys array' do
      expect(journey_log.journeys).to be_empty
    end

    it 'should be able to start with a journey object' do
      expect(journey_log.journey_class).to eq journey_class
    end
  end

  describe "#start" do
    it 'should be able to start journey' do
      expect(journey).to receive(:start).with(station)
      journey_log.start(station)
    end
  end

  describe "#finish" do
    it 'should be able to finish journey' do
      expect(journey).to receive(:finish).with(station_2)
      journey_log.finish(station_2)
    end

    it 'should save finished journey' do
      journey_log.start(station)
      journey_log.finish(station_2)
      expect(journey_log.journeys).to include journey.data
    end

  end


end
