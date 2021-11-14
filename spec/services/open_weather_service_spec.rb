require 'rails_helper'

RSpec.describe 'OpenWeather service' do
  describe '#get_weather(lat, lon)' do
    it 'gets the weather for a latitude and longitude', :vcr do
      # lat and lng for Denver
      geo = {lat: 39.738453, lon: -104.984853}
      response = OpenWeatherService.get_weather(geo)

      expect(response).to be_a(Hash)

      expect(response).to have_key(:current)
      expect(response[:current]).to be_a(Hash)

      expect(response[:current]).to                 have_key(:dt)
      expect(response[:current]).to                 have_key(:sunrise)
      expect(response[:current]).to                 have_key(:sunset)
      expect(response[:current]).to                 have_key(:temp)
      expect(response[:current]).to                 have_key(:feels_like)
      expect(response[:current]).to                 have_key(:humidity)
      expect(response[:current]).to                 have_key(:uvi)
      expect(response[:current]).to                 have_key(:visibility)
      expect(response[:current]).to                 have_key(:weather)
      expect(response[:current][:weather].first).to have_key(:description)
      expect(response[:current][:weather].first).to have_key(:icon)

      expect(response[:current][:dt]).to                          be_an(Integer)
      expect(response[:current][:sunrise]).to                     be_an(Integer)
      expect(response[:current][:sunset]).to                      be_an(Integer)
      expect(response[:current][:temp]).to                        be_a(Float)
      expect(response[:current][:feels_like]).to                  be_a(Float)
      expect(response[:current][:humidity]).to                    be_an(Integer)
      expect(response[:current][:uvi]).to                         be_a(Float)
      expect(response[:current][:visibility]).to                  be_an(Integer)
      expect(response[:current][:weather]).to                     be_an(Array)
      expect(response[:current][:weather].first[:description]).to be_a(String)
      expect(response[:current][:weather].first[:icon]).to        be_a(String)

      expect(response).to                               have_key(:daily)
      expect(response[:daily].first).to                 have_key(:dt)
      expect(response[:daily].first).to                 have_key(:sunrise)
      expect(response[:daily].first).to                 have_key(:sunset)
      expect(response[:daily].first).to                 have_key(:temp)
      expect(response[:daily].first[:temp]).to          have_key(:max)
      expect(response[:daily].first[:temp]).to          have_key(:min)
      expect(response[:daily].first).to                 have_key(:weather)
      expect(response[:daily].first[:weather].first).to have_key(:description)
      expect(response[:daily].first[:weather].first).to have_key(:icon)

      expect(response[:daily]).to be_an(Array)
      expect(response[:daily].first[:dt]).to                          be_an(Integer)
      expect(response[:daily].first[:sunrise]).to                     be_an(Integer)
      expect(response[:daily].first[:sunset]).to                      be_an(Integer)
      expect(response[:daily].first[:temp]).to                        be_a(Hash)
      expect(response[:daily].first[:temp][:max]).to                  be_a(Float)
      expect(response[:daily].first[:temp][:min]).to                  be_a(Float)
      expect(response[:daily].first[:weather]).to                     be_an(Array)
      expect(response[:daily].first[:weather].first[:description]).to be_a(String)
      expect(response[:daily].first[:weather].first[:icon]).to        be_a(String)

      expect(response).to                                have_key(:hourly)
      expect(response[:hourly].first).to                 have_key(:dt)
      expect(response[:hourly].first).to                 have_key(:temp)
      expect(response[:hourly].first).to                 have_key(:weather)
      expect(response[:hourly].first[:weather].first).to have_key(:description)
      expect(response[:hourly].first[:weather].first).to have_key(:icon)

      expect(response[:hourly]).to be_an(Array)
      expect(response[:hourly].first[:dt]).to                          be_an(Integer)
      expect(response[:hourly].first[:temp]).to                        be_a(Float)
      expect(response[:hourly].first[:weather]).to                     be_an(Array)
      expect(response[:hourly].first[:weather].first[:description]).to be_a(String)
      expect(response[:hourly].first[:weather].first[:icon]).to        be_a(String)
    end
  end
end
