
class Oystercard
  attr_reader :balance, :in_use
  MAXIMUM_CARD_LIMIT = 90
  TRAVEL_BALANCE = 1
  MINUMUM_CHARGE = 1

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    raise 'Maximum card limit exceeded' if @balance + amount > MAXIMUM_CARD_LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount

  end

  def in_journey?
    @in_use
  end

  def touch_in
    raise 'Insufficent funds' if @balance < TRAVEL_BALANCE
    @in_use = true
  end

  def touch_out
    deduct(MINUMUM_CHARGE)
    @in_use
  end

end
