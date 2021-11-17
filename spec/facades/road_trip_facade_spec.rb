require 'rails_helper'

RSpec.describe RoadTripFacade do
  describe '.get_road_trip(params)', :vcr do
    it 'it can receive valid params and make a facade' do
      params = { origin: 'new york,ny, destination: los angeles, ca' }
      trip = RoadTripFacade.get_road_trip(params)
      expect(trip).to be_a(RoadTrip)
    end

    it 'can make a road trip with impossible route' do
      params = { origin: 'new york,ny, destination: london, uk' }
      trip = RoadTripFacade.get_road_trip(params)
      expect(trip).to be_a(RoadTrip)
    end
  end

  describe '.road_trip_params(route)' do
    it 'formats road trip params' do
      route_data = File.read('spec/fixtures/ny_to_la.json')
      route = JSON.parse(route_data, symbolize_names: true)
      expectation = {
        start_city: 'New York, NY',
        end_city: 'Los Angeles, CA',
        travel_time: '40:16:00'
      }
      expect(RoadTripFacade.road_trip_params(route)).to eq(expectation)
    end
  end
end
