class JourneyLog

  attr_reader :journey_class

  def initialize(journey_class)
    @journeys = []
    @journey_class = journey_class
    @current_journey
  end

  def start(station)
    current_journey.start(station)
  end

  def finish(station)
    current_journey.finish(station)
  end
  
  def journeys
    @journeys.dup
  end

  private

  def current_journey
    @current_journey ||= @journey_class.new
  end

end
