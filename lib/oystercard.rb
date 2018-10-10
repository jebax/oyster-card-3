

class Oystercard
  BALANCE_MAX = 90
  BALANCE_MIN = 1

  attr_reader :balance, :entry_station, :journeys

  def initialize
    @balance = 0
    @current_journey
    @journeys = []
  end

  def top_up(amount)
    raise "Max (£#{BALANCE_MAX}) exceeded" if balance + amount > BALANCE_MAX
    @balance += amount
  end

  def in_journey?
    !!@current_journey
  end

  def touch_in(station)
    deduct_fare(current_journey.fare) if in_journey?
    raise "Below card minimum (£#{BALANCE_MIN})" if balance < BALANCE_MIN
    current_journey.start(station)
  end

  def touch_out(station)
    current_journey.finish(station)
    deduct_fare(current_journey.fare)
    finish_journey
  end

  private

  def deduct_fare(fare)
    @balance -= fare
  end

  def finish_journey
    @journeys << current_journey.data
    @current_journey = nil
  end

  def current_journey
    @current_journey ||= Journey.new
  end

end
