require 'rails_helper'

RSpec.describe BackgroundService do
  describe '#get_background_data(location)' do
    it 'gets background data for the location', :vcr do
      response = BackgroundService.get_background_data('denver,co')

      expect(response).to be_a(Hash)

      expect(response).to have_key(:results)

      expect(response[:results]).to be_an(Array)

      expect(response[:results].first).to be_a(Hash)
      expect(response[:results].first).to have_key(:urls)
      expect(response[:results].first).to have_key(:links)
      expect(response[:results].first).to have_key(:user)

      expect(response[:results].first[:urls]).to have_key(:raw)
      expect(response[:results].first[:urls]).to have_key(:full)
      expect(response[:results].first[:urls]).to have_key(:regular)
      expect(response[:results].first[:urls]).to have_key(:small)
      expect(response[:results].first[:urls]).to have_key(:thumb)

      expect(response[:results].first[:urls][:raw]).to     be_a(String)
      expect(response[:results].first[:urls][:full]).to    be_a(String)
      expect(response[:results].first[:urls][:regular]).to be_a(String)
      expect(response[:results].first[:urls][:small]).to   be_a(String)
      expect(response[:results].first[:urls][:thumb]).to   be_a(String)
      # binding.pry
      expect(response[:results].first[:links]).to have_key(:self)
      expect(response[:results].first[:links]).to have_key(:html)
      expect(response[:results].first[:links]).to have_key(:download)
      expect(response[:results].first[:links]).to have_key(:download_location)

      expect(response[:results].first[:links][:self]).to              be_a(String)
      expect(response[:results].first[:links][:html]).to              be_a(String)
      expect(response[:results].first[:links][:download]).to          be_a(String)
      expect(response[:results].first[:links][:download_location]).to be_a(String)

      expect(response[:results].first[:user]).to have_key(:name)
      expect(response[:results].first[:user][:name]).to be_a(String)

      expect(response[:results].first[:user]).to have_key(:links)
      expect(response[:results].first[:user][:links]).to be_a(Hash)

      expect(response[:results].first[:user][:links]).to have_key(:self)
      expect(response[:results].first[:user][:links][:self]).to be_a(String)
    end
  end
end
