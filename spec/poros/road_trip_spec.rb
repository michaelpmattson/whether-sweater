require 'rails_helper'

RSpec.describe RoadTrip do
  describe '#initialize' do
    before(:each) do
      road_trip_data = {:start_city=>"Denver, CO", :end_city=>"Pueblo, CO", :travel_time=>"01:45:23"}

      weather_file = File.read('spec/fixtures/pueblo_weather.json')
      @weather_data = JSON.parse(weather_file, symbolize_names: true)

      @trip = RoadTrip.new(road_trip_data, @weather_data)
    end

    it 'exists and has attributes' do
      expect(@trip).to be_a(RoadTrip)
      expect(@trip.id).to be_nil
      expect(@trip.start_city).to eq('Denver, CO')
      expect(@trip.end_city).to eq('Pueblo, CO')
      expect(@trip.travel_time).to eq('01:45:23')
      expect(@trip.weather_at_eta).to be_a(Hash)
    end

    it '#get_weather_at_eta(weather)' do
      expectation = { temperature: 67.5, conditions: 'few clouds'}
      expect(@trip.get_weather_at_eta(@weather_data)).to eq(expectation)
    end

    it '#calc_hours' do
      expect(@trip.calc_hours).to eq(1)
    end
  end
end
