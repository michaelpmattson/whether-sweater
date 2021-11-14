require 'rails_helper'

RSpec.describe HourlyForecast do
  before(:each) do
    response = File.read('spec/fixtures/denver_weather_example.json')
    @data    = JSON.parse(response, symbolize_names: true)[:hourly].first
    @hourly  = HourlyForecast.new(@data)
  end

  describe '#initialize' do
    it 'exists and has attributes' do
      expect(@hourly).to             be_an(HourlyForecast)
      expect(@hourly.time).to        be_a(String)
      expect(@hourly.temperature).to be_a(Float)
      expect(@hourly.conditions).to  be_a(String)
      expect(@hourly.icon).to        be_a(String)
    end
  end

  describe '#unix_to_readable_time(unix_dt)' do
    it 'converts unix dt to readable date' do
      dt = @data[:dt]
      expect(@hourly.unix_to_readable_time(dt)).to eq("12:00:00")
    end
  end
end


# hourly_weather, array of the next 8 hours of hourly weather data:
# time, in a human-readable format such as “14:00:00”
# temperature, floating point number indicating the current temperature in Fahrenheit
# conditions, the first ‘description’ field from the weather data as given by OpenWeather
# icon, string, as given by OpenWeather
