require 'journey'

describe Journey do

  let(:station) { double(:station, name: "Aldgate", zone: 1)}

  it 'should have an empty data hash when created' do
    data = {entry_station: nil, exit_station: nil}
    expect(subject.data).to eq data
  end

  describe '#start' do
    it 'should save entry station' do
      subject.start(station)
      expect(subject.data[:entry_station]).to eq station
    end
  end

  describe '#finish' do
    it 'should save exit station' do
      subject.finish(station)
      expect(subject.data[:exit_station]).to eq station
    end
  end

  describe '#complete?' do
    it 'should return true if journey has started and finished' do
      subject.start(station)
      subject.finish(station)
      expect(subject).to be_complete
    end

    it 'should return false if journey has not started' do
      subject.finish(station)
      expect(subject).not_to be_complete
    end

    it 'should return false if journey has not finished' do
      subject.start(station)
      expect(subject).not_to be_complete
    end

  end


end
