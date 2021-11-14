require 'rails_helper'

RSpec.describe CurrentForecast do
  before(:each) do
    response = File.read('spec/fixtures/denver_weather_example.json')
    @data     = JSON.parse(response, symbolize_names: true)[:current]
    @current  = CurrentForecast.new(@data)
  end

  describe '#initialize' do
    it 'exists and has attributes' do
      expect(@current).to             be_a(CurrentForecast)
      expect(@current.datetime).to    be_a(String)
      expect(@current.sunrise).to     be_a(String)
      expect(@current.sunset).to      be_a(String)
      expect(@current.temperature).to be_a(Float)
      expect(@current.feels_like).to  be_a(Float)
      expect(@current.humidity).to    be_an(Integer)
      expect(@current.uvi).to         be_a(Float)
      expect(@current.visibility).to  be_an(Integer)
      expect(@current.conditions).to  be_a(String)
      expect(@current.icon).to        be_a(String)
    end
  end

  describe '#unix_to_readable_datetime(unix_dt)' do
    it 'converts unix utc dt to readable dt' do
      dt = @data[:dt]
      expect(@current.unix_to_readable_datetime(dt)).to eq("2021-11-13 12:48:52 -0700")
    end
  end
end
