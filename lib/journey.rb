class Journey

  def initialize
    @data = {entry_station: nil, exit_station: nil}
  end

  def data
    @data.dup
  end

  def start(station)
    @data[:entry_station] = station
  end

  def finish(station)
    @data[:exit_station] = station
  end

  def complete?
    @data[:entry_station] && @data[:exit_station]
  end

end
