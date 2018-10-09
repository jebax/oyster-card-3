require 'oystercard'
require 'pry'

describe Oystercard do
  let(:station) { double(:station, name: :london_bridge)}

  describe '#balance' do
    it 'should have a balance of 0' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }
    it 'tops up money to the card' do
      subject.top_up(5)
      expect { subject.top_up(5) }.to change { subject.balance }.by(5)
    end

    it 'raises and error if maximum card limit exceeded' do
      expect { subject.top_up(91) }.to raise_error 'Maximum card limit exceeded'
    end
  end

  describe '#deduct' do
    before do
      subject.top_up(10)
    end

    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'should deduct money from card' do
      expect { subject.deduct(10) }.to change { subject.balance }.by(-10)
    end
    
    it 'shoud deduct the minumum charge when you touch out' do
      subject.touch_in(station)
      expect { subject.touch_out }.to change { subject.balance }.by(-Oystercard::MINUMUM_CHARGE)
    end
  end

  describe '#in_journey' do
    it 'should show oyster card as not in journey when initialized' do
      expect(subject).not_to be_in_journey
    end
  end


  it 'can touch in' do
    subject.top_up(10)
    subject.touch_in(station)
    expect(subject).to be_in_journey
  end

  it 'can touch out' do
    subject.top_up(20)
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

  describe '#touch_in' do
    it 'raises an error if balance is less than 1' do
      expect { subject.touch_in(station) }.to raise_error 'Insufficent funds'
    end

    it'should remember the station after it touches in' do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station.name
    end
  end

  describe '#touch_out' do
    it 'should forget the entry station when it touches out' do
      subject.top_up(5)
      subject.touch_in(station)
      subject.touch_out
      expect(subject.entry_station).to eq nil
    end
  end

end
