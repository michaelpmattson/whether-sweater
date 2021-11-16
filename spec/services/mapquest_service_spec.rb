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

  describe '.get_trip_data(params)' do
    it 'gets a trip for an origin and destination', :vcr do
      params   = { origin: 'denver,co', destination: 'pueblo,co' }
      response = MapquestService.get_trip_data(params)

      expect(response).to be_a(Hash)

      expect(response).to have_key(:route)
      expect(response).to have_key(:info)

      expect(response[:route]).to be_a(Hash)
      expect(response[:info]).to  be_a(Hash)

      expect(response[:route]).to have_key(:locations)
      expect(response[:route]).to have_key(:formattedTime)
      expect(response[:route]).to have_key(:legs)
      expect(response[:route][:locations]).to be_an(Array)
      expect(response[:route][:formattedTime]).to be_a(String)
      expect(response[:route][:legs]).to be_an(Array)

      response[:route][:locations].each do |location|
        expect(location).to have_key(:adminArea5) # city
        expect(location).to have_key(:adminArea3) # state
        expect(location[:adminArea5]).to be_a(String)
        expect(location[:adminArea3]).to be_a(String)
      end

      expect(response[:info]).to have_key(:statuscode)
      expect(response[:info][:statuscode]).to eq(0)
    end
  end
end
