
class Oystercard
  attr_reader :balance, :in_use, :entry_station, :journeys
  MAXIMUM_CARD_LIMIT = 90
  TRAVEL_BALANCE = 1
  MINUMUM_CHARGE = 1


  def initialize
    @balance = 0
    @entry_station
    @journeys = []
  end

  def top_up(amount)
    raise 'Maximum card limit exceeded' if @balance + amount > MAXIMUM_CARD_LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(station)
    raise 'Insufficent funds' if @balance < TRAVEL_BALANCE
    @entry_station = station.name
  end

  def touch_out(station)
    deduct(MINUMUM_CHARGE)
    @journeys << { entry_station: @entry_station, exit_station: station.name }
    @entry_station = nil
  end


end
