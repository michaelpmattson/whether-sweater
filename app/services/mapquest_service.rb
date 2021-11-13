class MapquestService
  def self.get_geocoding(address)
    response = Faraday.get("http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['mapquest_key']}&location=#{address}")
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
