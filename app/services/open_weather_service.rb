class OpenWeatherService < ApplicationService
  def self.get_weather(lat, lon)
    response = Faraday.get("https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{lon}&exclude=minutely,alerts&appid=#{ENV['open_weather_key']}")
    parse_json(response)
  end
end
