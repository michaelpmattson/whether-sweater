class OpenWeatherService
  def self.get_weather(lat, lon)
    response = Faraday.get("https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{lon}&exclude=minutely,alerts&appid=#{ENV['open_weather_key']}")
    parse_json(response)
  end

  private

  # def self.conn
  #   Faraday.new(url: 'http://www.mapquestapi.com') do |faraday|
  #     faraday.headers['key'] = ENV['mapquest_key']
  #   end
  # end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
