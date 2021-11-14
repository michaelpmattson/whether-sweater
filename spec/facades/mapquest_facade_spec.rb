require 'rails_helper'

RSpec.describe MapquestFacade do
  describe '.get_geolocation(address)', :vcr do
    it 'returns lat and lng in a hash' do
      geo = {:lat=>39.738453, :lng=>-104.984853}
      expect(MapquestFacade.get_geolocation('denver,co')).to eq(geo)
    end
  end
end
