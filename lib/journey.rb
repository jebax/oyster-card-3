class Journey
  MINIMUM_CHARGE = 1
  PENALTY_FARE = 6

  def initialize
    @data = {entry: nil, exit: nil}
  end

  def data
    @data.dup
  end

  def start(station)
    @data[:entry] = station
  end

  def finish(station)
    @data[:exit] = station
  end

  def complete?
    @data[:entry] && @data[:exit]
  end

  def fare
    return calculate_fare if complete?
    PENALTY_FARE
  end

  private
  def calculate_fare
    1 + (@data[:entry].zone - @data[:exit].zone).abs
  end

end
