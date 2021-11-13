require 'rails_helper'

RSpec.describe 'Mapquest service' do
  describe '#get_geocoding(address)' do
    it 'gets geocoding for an address or city' do
      response = MapquestService.get_geocoding('Denver,CO')

      expect(response).to be_a(Hash)
    end
  end
end
