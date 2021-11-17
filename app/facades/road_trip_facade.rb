class RoadTripFacade
  def self.get_road_trip(params)
    trip_data = MapquestService.get_trip_data(params)
    if trip_data[:info][:statuscode].zero?
      dest_geo  = trip_data[:route][:legs].first[:maneuvers].last[:startPoint]
      weather_data = OpenWeatherService.get_weather({lat: dest_geo[:lat], lon: dest_geo[:lng]})
      rt = RoadTrip.new(road_trip_params(trip_data), weather_data)
    else
      trip_data = {
        start_city: params[:origin],
        end_city: params[:destination],
        travel_time: 'impossible'
      }
      weather_data = {}
      rt = RoadTrip.new(trip_data, weather_data)
    end
  end

  private

  def self.road_trip_params(route)
    {
      start_city:  "#{route[:route][:locations].first[:adminArea5]}, #{route[:route][:locations].first[:adminArea3]}",
      end_city:    "#{route[:route][:locations].last[:adminArea5]}, #{route[:route][:locations].last[:adminArea3]}",
      travel_time: route[:route][:formattedTime]
    }
  end
end
