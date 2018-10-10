# frozen_string_literal: true

require 'journey'

describe Journey do
  let(:station_1) { double(:station_1, name: 'Aldgate', zone: 1) }
  let(:station_2) { double(:station_2, name: 'Brixton', zone: 2) }
  let(:station_5) { double(:station_5, name: 'Cockfosters', zone: 5) }

  it 'should have an empty data hash when created' do
    data = { entry: nil, exit: nil }
    expect(subject.data).to eq data
  end

  describe '#start' do
    it 'should save entry station' do
      subject.start(station_1)
      expect(subject.data[:entry]).to eq station_1
    end
  end

  describe '#finish' do
    it 'should save exit station' do
      subject.finish(station_1)
      expect(subject.data[:exit]).to eq station_1
    end
  end

  describe '#complete?' do
    it 'should return true if journey has started and finished' do
      subject.start(station_1)
      subject.finish(station_1)
      expect(subject).to be_complete
    end

    it 'should return false if journey has not started' do
      subject.finish(station_1)
      expect(subject).not_to be_complete
    end

    it 'should return false if journey has not finished' do
      subject.start(station_1)
      expect(subject).not_to be_complete
    end
  end

  describe '#fare' do
    it 'should charge 1 when travelling in the same zone' do
      subject.start(station_1)
      subject.finish(station_1)
      expect(subject.fare).to eq described_class::MINIMUM_CHARGE
    end

    it 'should charge 2 when travelling over one zone' do
      subject.start(station_1)
      subject.finish(station_2)
      expect(subject.fare).to eq 2
    end

    it 'should charge 5 when travelling in the same zone' do
      subject.start(station_1)
      subject.finish(station_5)
      expect(subject.fare).to eq 5
    end

    it 'should return the penalty fare if journey was not finished' do
      subject.start(station_1)
      expect(subject.fare).to eq described_class::PENALTY_FARE
    end

    it 'should return the penalty fare if journey was not started' do
      subject.finish(station_1)
      expect(subject.fare).to eq described_class::PENALTY_FARE
    end
  end
end
