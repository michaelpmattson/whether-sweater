class RoadTrip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(route, weather)
    @id = nil
    @start_city = route[:start_city]
    @end_city   = route[:end_city]
    @travel_time = route[:travel_time]
    @weather_at_eta = get_weather_at_eta(weather)
  end

  def get_weather_at_eta(weather)
    return weather if weather.empty?

    hours = calc_hours
    w = weather[:hourly][hours]
    {
      temperature: w[:temp],
      conditions: w[:weather].first[:description]
    }
  end

  def calc_hours
    @travel_time.split(':').first.to_i
  end
end
