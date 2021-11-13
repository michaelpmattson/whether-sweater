class MapquestService < ApplicationService
  def self.get_geocoding(address)
    response = Faraday.get("http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['mapquest_key']}&location=#{address}")
    parse_json(response)
  end
end
