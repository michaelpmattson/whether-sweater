require 'rails_helper'

RSpec.describe OpenWeatherFacade do
  describe '.get_forecast(geolocation)', :vcr do
    it 'returns a forecast' do
      geo = {:lat=>39.738453, :lon=>-104.984853}
      expect(OpenWeatherFacade.get_forecast(geo)).to be_a(Forecast)
    end
  end
end
