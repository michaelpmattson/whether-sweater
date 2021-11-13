require 'rails_helper'

RSpec.describe 'Mapquest service' do
  describe '#get_geocoding(address)' do
    it 'gets geocoding for an address or city', :vcr do
      response = MapquestService.get_geocoding('Denver,CO')

      expect(response).to be_a(Hash)

      expect(response).to have_key(:results)
      expect(response[:results]).to be_an(Array)


      expect(response[:results].first).to have_key(:locations)
      expect(response[:results].first[:locations]).to be_an(Array)

      expect(response[:results].first[:locations].first).to have_key(:latLng)
      expect(response[:results].first[:locations].first[:latLng]).to be_a(Hash)

      expect(response[:results].first[:locations].first[:latLng]).to have_key(:lat)
      expect(response[:results].first[:locations].first[:latLng][:lat]).to be_a(Float)

      expect(response[:results].first[:locations].first[:latLng]).to have_key(:lng)
      expect(response[:results].first[:locations].first[:latLng][:lng]).to be_a(Float)
    end
  end
end
