# frozen_string_literal: true

require 'oystercard'

describe Oystercard do
  let(:station) { double :station, name: :aldgate }
  let(:station_2) { double :station, name: :euston }
  let(:journey) { double(:journey, start: nil, finish: nil, fare: 1, data: { entry: station, exit: station_2 }) }
  let(:journey_class) { double(:journey_class, new: journey) }
  let(:subject) { Oystercard.new(journey_class) }

  it { expect(subject.balance).to eq 0 }

  it 'should not be in journey when created' do
    expect(subject).not_to be_in_journey
  end

  it 'cannot touch in with less than minimum balance' do
    minimum = described_class::BALANCE_MIN
    message = "Below card minimum (£#{minimum})"
    expect { subject.touch_in(station) }.to raise_error message
  end

  describe '#top_up' do
    it 'should top up balance by a specified amount' do
      expect { subject.top_up 10 }.to change { subject.balance }.by 10
    end

    it 'should not be able to top up beyond the maximum card limit' do
      limit = described_class::BALANCE_MAX
      message = "Max (£#{limit}) exceeded"
      expect { subject.top_up limit + 1 }.to raise_error message
    end
  end

  context 'has sufficient card balance' do
    before do
      subject.top_up(10)
    end

    it 'touch in means card is in journey' do
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'touching out means card is not in journey' do
      subject.touch_in(station)
      subject.touch_out(station_2)
      expect(subject).not_to be_in_journey
    end

    it 'deducts fare on touching out' do
      charge = 1
      subject.touch_in(station)
      expect { subject.touch_out(station) }.to change \
      { subject.balance }.by(0 - charge)
    end

    it 'deducts penalty fare if touch in without touching out' do
      allow(journey).to receive(:fare).and_return(6)
      2.times { subject.touch_in(station) }
      expect(subject.balance).to eq 4
    end
  end
end
