# frozen_string_literal: true

class JourneyLog
  attr_reader :journey_class

  def initialize(journey_class)
    @journeys = []
    @journey_class = journey_class
  end

  def start(station)
    current_journey.start(station)
  end

  def finish(station)
    current_journey.finish(station)
    log_journey
  end

  def journeys
    @journeys.dup
  end

  def current_journey
    @current_journey ||= @journey_class.new
  end

  private

  def log_journey
    @journeys << current_journey.data
  end
end
