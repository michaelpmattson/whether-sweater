class MapquestFacade
  def self.get_geolocation(address)
    geocoding = MapquestService.get_geocoding(address)
    geocoding[:results].first[:locations].first[:latLng]
  end
end
