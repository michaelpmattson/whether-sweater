class OpenWeatherService < ApplicationService
  def self.get_weather(geolocation)
    response = Faraday.get("https://api.openweathermap.org/data/2.5/onecall?lat=#{geolocation[:lat]}&lon=#{geolocation[:lon]}&exclude=minutely,alerts&units=imperial&appid=#{ENV['open_weather_key']}")
    parse_json(response)
  end
end
