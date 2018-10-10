

class Oystercard
  BALANCE_MAX = 90
  BALANCE_MIN = 1

  attr_reader :balance, :entry_station, :journeys

  def initialize(journey_class)
    @balance = 0
    @log = JourneyLog.new(journey_class)
    @in_journey
  end

  def top_up(amount)
    raise "Max (£#{BALANCE_MAX}) exceeded" if balance + amount > BALANCE_MAX
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in(station)
    deduct_fare(@log.current_journey.fare) if in_journey?
    raise "Below card minimum (£#{BALANCE_MIN})" if balance < BALANCE_MIN
    @log.start(station)
    @in_journey = true
  end

  def touch_out(station)
    @log.finish(station)
    deduct_fare(@log.current_journey.fare)
    @in_journey = nil
  end

  private

  def deduct_fare(fare)
    @balance -= fare
  end

end
