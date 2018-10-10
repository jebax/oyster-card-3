require 'journey'

describe Journey do

  let(:station) { double(:station, name: "Aldgate", zone: 1)}

  it 'should have an empty data hash when created' do
    data = {entry: nil, exit: nil}
    expect(subject.data).to eq data
  end

  describe '#start' do
    it 'should save entry station' do
      subject.start(station)
      expect(subject.data[:entry]).to eq station
    end
  end

  describe '#finish' do
    it 'should save exit station' do
      subject.finish(station)
      expect(subject.data[:exit]).to eq station
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

    describe "#fare" do
      it 'should return the minimum charge if journey is complete' do
        subject.start(station)
        subject.finish(station)
        expect(subject.fare).to eq described_class::MINIMUM_CHARGE
      end

      it 'should return the penalty fare if journey was not finished' do
        subject.start(station)
        expect(subject.fare).to eq described_class::PENALTY_FARE
      end

      it 'should return the penalty fare if journey was not started' do
        subject.finish(station)
        expect(subject.fare).to eq described_class::PENALTY_FARE
      end
    end

  end


end
