class MapquestService < ApplicationService
  def self.get_geocoding(address)
    response = Faraday.get("http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['mapquest_key']}&location=#{address}")
    parse_json(response)
  end

  def self.get_trip_data(params)
    response = Faraday.get("http://www.mapquestapi.com/directions/v2/route?key=#{ENV['mapquest_key']}&from=#{params[:origin]}&to=#{params[:destination]}")
    parse_json(response)
  end
end
