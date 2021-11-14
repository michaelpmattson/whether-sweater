require 'rails_helper'

RSpec.describe ForecastSerializer do
  before(:each) do
    forecast_data = File.read('spec/fixtures/denver_weather_example.json')
    forecast_hash = JSON.parse(forecast_data, symbolize_names: true)
    forecast      = Forecast.new(forecast_hash)
    @serialized   = ForecastSerializer.format_forecast(forecast)
  end

  it 'serializes forecast object into json' do
    expect(@serialized).to be_a(Hash)
    expect(@serialized).to have_key(:data)

    expect(@serialized[:data]).to be_a(Hash)
    expect(@serialized[:data]).to have_key(:id)
    expect(@serialized[:data]).to have_key(:type)
    expect(@serialized[:data]).to have_key(:attributes)
    expect(@serialized[:data][:attributes]).to have_key(:current_weather)
    expect(@serialized[:data][:attributes]).to have_key(:daily_weather)
    expect(@serialized[:data][:attributes]).to have_key(:hourly_weather)

    current_weather = @serialized[:data][:attributes][:current_weather]
    daily_weather   = @serialized[:data][:attributes][:daily_weather]
    hourly_weather  = @serialized[:data][:attributes][:hourly_weather]

    expect(current_weather).to have_key(:datetime)
    expect(current_weather).to have_key(:sunrise)
    expect(current_weather).to have_key(:sunset)
    expect(current_weather).to have_key(:temperature)
    expect(current_weather).to have_key(:feels_like)
    expect(current_weather).to have_key(:humidity)
    expect(current_weather).to have_key(:uvi)
    expect(current_weather).to have_key(:visibility)
    expect(current_weather).to have_key(:conditions)
    expect(current_weather).to have_key(:icon)

    expect(current_weather[:datetime]).to    be_an(String)
    expect(current_weather[:sunrise]).to     be_an(String)
    expect(current_weather[:sunset]).to      be_an(String)
    expect(current_weather[:temperature]).to be_a(Float)
    expect(current_weather[:feels_like]).to  be_a(Float)
    expect(current_weather[:humidity]).to    be_an(Integer)
    expect(current_weather[:uvi]).to         be_a(Float)
    expect(current_weather[:visibility]).to  be_an(Integer)
    expect(current_weather[:conditions]).to  be_a(String)
    expect(current_weather[:icon]).to        be_a(String)

    expect(daily_weather.first).to have_key(:date)
    expect(daily_weather.first).to have_key(:sunrise)
    expect(daily_weather.first).to have_key(:sunset)
    expect(daily_weather.first).to have_key(:max_temp)
    expect(daily_weather.first).to have_key(:min_temp)
    expect(daily_weather.first).to have_key(:conditions)
    expect(daily_weather.first).to have_key(:icon)

    expect(daily_weather).to                    be_an(Array)
    expect(daily_weather.first[:date]).to       be_a(String)
    expect(daily_weather.first[:sunrise]).to    be_a(String)
    expect(daily_weather.first[:sunset]).to     be_a(String)
    expect(daily_weather.first[:max_temp]).to   be_a(Float)
    expect(daily_weather.first[:min_temp]).to   be_a(Float)
    expect(daily_weather.first[:conditions]).to be_a(String)
    expect(daily_weather.first[:icon]).to       be_a(String)

    expect(hourly_weather.first).to have_key(:time)
    expect(hourly_weather.first).to have_key(:temperature)
    expect(hourly_weather.first).to have_key(:conditions)
    expect(hourly_weather.first).to have_key(:icon)

    expect(hourly_weather).to                     be_an(Array)
    expect(hourly_weather.first[:time]).to        be_a(String)
    expect(hourly_weather.first[:temperature]).to be_a(Float)
    expect(hourly_weather.first[:conditions]).to  be_a(String)
    expect(hourly_weather.first[:icon]).to        be_a(String)
  end
end
