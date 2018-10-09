require 'oystercard'

describe Oystercard do

  describe '#balance' do
    it 'should have a balance of 0' do
      card = Oystercard.new
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }
    it 'tops up money to the card' do
      card = Oystercard.new
      card.top_up(5)
      expect { subject.top_up(5) }.to change { subject.balance }.by(5)
    end

    it 'raises and error if maximum card limit exceeded' do
      card = Oystercard.new
      expect { subject.top_up(91) }.to raise_error 'Maximum card limit exceeded'
    end
  end

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }
    it 'should deduct money from card' do
      card = Oystercard.new
      card.top_up(50)
      expect { subject.deduct(10) }.to change { subject.balance }.by(-10)
    end
  end

  describe '#in_journey' do
    it 'should show oyster card as not in journey when initialized' do
      card = Oystercard.new
      expect(subject).not_to be_in_journey
    end
  end


  it 'can touch in' do
    card = Oystercard.new
    subject.top_up(10)
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it 'can touch out' do
    card = Oystercard.new
    subject.top_up(20)
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

  describe '#touch_in' do
    it 'raises an error if balance is less than 1' do
      card = Oystercard.new
      expect { subject.touch_in}.to raise_error 'Insufficent funds'
    end
  end

end
