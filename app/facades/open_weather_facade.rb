class OpenWeatherFacade
  def self.get_forecast(geolocation)
    weather_data = OpenWeatherService.get_weather(geolocation)
    Forecast.new(weather_data)
  end
end
