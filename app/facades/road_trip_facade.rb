class RoadTripFacade
  def self.get_road_trip(params)
    trip_data = MapquestService.get_trip_data(params)
    dest_geo  = trip_data[:route][:legs].first[:maneuvers].last[:startPoint]
    weather_data = OpenWeatherService.get_weather({lat: dest_geo[:lat], lon: dest_geo[:lng]})
    rt = RoadTrip.new(trip_data, weather_data)
    binding.pry
  end
end
