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
      expect { subject.top_up(10) }.to change { subject.balance }.by(10)
    end
  end
end
