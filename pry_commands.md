require "./lib/oystercard"
require "./lib/station"
require "./lib/journey"
require "./lib/journey_log"
aldgate = Station.new("Aldgate", 1)
brixton = Station.new("Brixton", 2)
cockfosters = Station.new("Cockfosters", 5)
card = Oystercard.new(Journey)
