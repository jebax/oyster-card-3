class Journey
  MINIMUM_CHARGE = 1
  PENALTY_FARE = 6

  attr_reader :data

  def initialize
    @data = { entry_station: nil,
              entry_zone: nil,
              exit_station: nil,
              exit_zone: nil
    }
  end

  def start(station)
    @data[:entry_station] = station.name
    @data[:entry_zone] = station.zone
  end

  def finish(station)
    @data[:exit_station] = station.name
    @data[:exit_zone] = station.zone
  end

  def complete?
    !@data.values.include?(nil)
  end

  def fare
    if complete?
      MINIMUM_CHARGE
    else
      PENALTY_FARE
    end
  end

end
