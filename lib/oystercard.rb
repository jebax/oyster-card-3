
class Oystercard
  attr_reader :balance
  MAXIMUM_CARD_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise 'Maximum card limit exceeded' if balance + amount > MAXIMUM_CARD_LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end
end
