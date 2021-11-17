require 'rails_helper'
# forecast_hash = JSON.parse(forecast_data, symbolize_names: true)
# forecast      = Forecast.new(forecast_hash)
# @serialized   = ForecastSerializer.format_forecast(forecast)
RSpec.describe RoadTripSerializer do
  describe 'happy path' do
    before(:each) do
      route_data = File.read('spec/fixtures/ny_to_la.json')
      weather_data = File.read('spec/fixtures/la_weather.json')

      route_parsed = JSON.parse(route_data, symbolize_names: true)
      weather_hash = JSON.parse(weather_data, symbolize_names: true)

      route_hash = {
        start_city: "#{route_parsed[:route][:locations].first[:adminArea5]}, #{route_parsed[:route][:locations].first[:adminArea3]}",
        end_city: "#{route_parsed[:route][:locations].last[:adminArea5]}, #{route_parsed[:route][:locations].last[:adminArea3]}",
        travel_time: route_parsed[:route][:formattedTime]
      }

      road_trip = RoadTrip.new(route_hash, weather_hash)

      @serialized = RoadTripSerializer.new(road_trip).serializable_hash
    end

    it 'serializes a trip' do
      expect(@serialized).to                                      have_key(:data)
      expect(@serialized[:data]).to                               have_key(:id)
      expect(@serialized[:data]).to                               have_key(:type)
      expect(@serialized[:data]).to                               have_key(:attributes)
      expect(@serialized[:data][:attributes]).to                  have_key(:start_city)
      expect(@serialized[:data][:attributes]).to                  have_key(:end_city)
      expect(@serialized[:data][:attributes]).to                  have_key(:travel_time)
      expect(@serialized[:data][:attributes]).to                  have_key(:weather_at_eta)
      expect(@serialized[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(@serialized[:data][:attributes][:weather_at_eta]).to have_key(:conditions)

      expect(@serialized[:data][:attributes]).to                                be_a(Hash)
      expect(@serialized[:data][:attributes][:start_city]).to                   be_a(String)
      expect(@serialized[:data][:attributes][:end_city]).to                     be_a(String)
      expect(@serialized[:data][:attributes][:travel_time]).to                  be_a(String)
      expect(@serialized[:data][:attributes][:weather_at_eta]).to               be_a(Hash)
      expect(@serialized[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
      expect(@serialized[:data][:attributes][:weather_at_eta][:conditions]).to  be_a(String)
    end
  end

  describe 'sad path' do
    before(:each) do
      trip_data = {
        start_city: 'new york,ny',
        end_city: 'london,uk',
        travel_time: 'impossible'
      }
      weather_data = {}
      road_trip = RoadTrip.new(trip_data, weather_data)

      @serialized = RoadTripSerializer.new(road_trip).serializable_hash
    end

    it 'can serialize an impossible trip' do
      expect(@serialized).to have_key(:data)
      expect(@serialized[:data]).to have_key(:id)
      expect(@serialized[:data]).to have_key(:type)
      expect(@serialized[:data]).to have_key(:attributes)
      expect(@serialized[:data][:attributes]).to have_key(:start_city)
      expect(@serialized[:data][:attributes]).to have_key(:end_city)
      expect(@serialized[:data][:attributes]).to have_key(:travel_time)
      expect(@serialized[:data][:attributes]).to have_key(:weather_at_eta)
      expect(@serialized[:data][:attributes][:weather_at_eta]).to_not have_key(:temperature)
      expect(@serialized[:data][:attributes][:weather_at_eta]).to_not have_key(:conditions)

      expect(@serialized[:data][:attributes]).to be_a(Hash)
      expect(@serialized[:data][:attributes][:start_city]).to be_a(String)
      expect(@serialized[:data][:attributes][:end_city]).to   be_a(String)
      expect(@serialized[:data][:attributes][:travel_time]).to eq('impossible')
      expect(@serialized[:data][:attributes][:weather_at_eta]).to eq({})
    end
  end


end
