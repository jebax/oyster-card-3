require 'oystercard'

describe Oystercard do

  describe '#balance' do
    it 'should have a balance of 0' do
      card = Oystercard.new
      expect(subject.balance).to eq(0)
    end
  end
end
