class Bike
  attr_accessor :size

  def suitable_bicycle(trip_date:, route_type:)

  end
end

class MountainBike < Bike
end

class RoadBike < Bike
end

class RentalBikes
  attr_accessor :mountain_bikes, :road_bikes, :available_date
end

class OwnedBikes
  attr_accessor :mountain_bikes, :road_bikes
end

class Trip
  attr_accessor :bike, :route, :technical_difficulty,
                :start_date, :end_date, :max_customers, :guide,
                :aerobic_difficulty

  def suitable_trips(date:, difficulty:)
  end
end

class Customer
  attr_accessor :aerobic_fitness, :mountain_bike_technical_skill_level
end

class Guide
end

class Route
  attr_accessor :aerobic_difficulty
end
