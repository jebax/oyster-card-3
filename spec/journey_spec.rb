require 'journey'

describe Journey do
  let(:station) { double(:station, name: :aldgate, zone: 1) }

  it 'should be created with an empty data store' do
    expect(subject.data).to eq({ :entry_station => nil,
                                 :entry_zone => nil,
                                 :exit_station => nil,
                                 :exit_zone => nil
    })
  end
  describe "#start" do
    it 'should be able to save station name when it starts' do
      subject.start(station)
      expect(subject.data.values).to include station.name
    end

    it 'should be able to save station zone when it starts' do
      subject.start(station)
      expect(subject.data.values).to include station.zone
    end
  end

  describe "#finish" do
    it 'should be able to save station name when it finishes' do
      subject.finish(station)
      expect(subject.data.values).to include station.name
    end

    it 'should be able to save station zone when it finishes' do
      subject.finish(station)
      expect(subject.data.values).to include station.zone
    end
  end

  describe "#complete?" do
    it 'should return true when a journey is complete' do
      subject.start(station)
      subject.finish(station)
      expect(subject.complete?).to eq true
    end

    it 'should return false when a journey was not started' do
      subject.finish(station)
      expect(subject.complete?).to eq false
    end

    it 'should return false when a journey was not finished' do
      subject.start(station)
      expect(subject.complete?).to eq false
    end
  end

  describe "#fare" do
    it 'should return the minimum fare if the journey is completed' do
      subject.start(station)
      subject.finish(station)
      expect(subject.fare).to eq described_class::MINIMUM_CHARGE
    end

    it 'should return the penalty fare if a journey is incomplete' do
      subject.start(station)
      expect(subject.fare).to eq described_class::PENALTY_FARE
    end
  end
end
