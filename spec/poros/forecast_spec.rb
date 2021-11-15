require 'rails_helper'

RSpec.describe Forecast do
  before(:each) do
    response = File.read('spec/fixtures/denver_weather_example.json')
    @data     = JSON.parse(response, symbolize_names: true)
    @forecast = Forecast.new(@data)
  end

  describe '#initialize' do
    it 'exists and has attributes' do

      expect(@forecast).to                 be_a(Forecast)
      expect(@forecast.current_weather).to be_a(CurrentForecast)
      expect(@forecast.daily_weather).to   be_an(Array)
      expect(@forecast.hourly_weather).to  be_an(Array)
    end
  end

  describe '#create_daily_forecasts(data)' do
    it 'makes 5 days of forecasts' do
      daily_weather = @forecast.create_daily_forecasts(@data[:daily])
      expect(daily_weather.count).to eq(5)
      daily_weather.each do |daily|
        expect(daily).to be_a(DailyForecast)
      end
    end
  end

  describe '#create_hourly_forecasts(data)' do
    it 'makes 8 hours of forecasts' do
      hourly_weather = @forecast.create_hourly_forecasts(@data[:hourly])
      expect(hourly_weather.count).to eq(8)
      hourly_weather.each do |hourly|
        expect(hourly).to be_a(HourlyForecast)
      end
    end
  end

  describe '#current_temperature' do
    it 'gets current temperature' do
      expect(@forecast.current_temperature).to eq(63.91)
    end
  end

  describe '#current_conditions' do
    it 'gets current temperature' do
      expect(@forecast.current_conditions).to eq('overcast clouds')
    end
  end
end


# id, always set to null
# type, always set to “forecast”
# attributes, an object containing weather information:

# current_weather, holds current weather data:


# daily_weather, array of the next 5 days of daily weather data:


# hourly_weather, array of the next 8 hours of hourly weather data:
