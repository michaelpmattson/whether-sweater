require 'rails_helper'

RSpec.describe DailyForecast do
  before(:each) do
    response  = File.read('spec/fixtures/denver_weather_example.json')
    @data     = JSON.parse(response, symbolize_names: true)[:daily].first
    @daily    = DailyForecast.new(@data)
  end

  describe '#initialize' do
    it 'exists and has attributes' do
      expect(@daily).to            be_a(DailyForecast)
      expect(@daily.date).to       be_a(String)
      expect(@daily.sunrise).to    be_a(String)
      expect(@daily.sunset).to     be_a(String)
      expect(@daily.max_temp).to   be_a(Float)
      expect(@daily.min_temp).to   be_a(Float)
      expect(@daily.conditions).to be_a(String)
      expect(@daily.icon).to       be_a(String)
    end
  end

  describe '#unix_to_readable_date(unix_dt)' do
    it 'converts unix dt to readable date' do
      dt = @data[:dt]
      expect(@daily.unix_to_readable_date(dt)).to eq("2021-11-13")
    end
  end
end
