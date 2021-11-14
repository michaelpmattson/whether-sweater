require 'rails_helper'

RSpec.describe Background do
  before(:each) do
    location       = 'denver,co'
    response_body  = File.read('spec/fixtures/denver_background_response.json')
    @data          = JSON.parse(response_body, symbolize_names: true)[:results].first
    @background    = Background.new(@data, location)
  end

  it 'exists and has attributes' do
    expect(@background).to be_a(Background)

    expect(@background.id).to       be_nil
    expect(@background.location).to eq('denver,co')
    expect(@background.url).to      eq('https://images.unsplash.com/photo-1634507307973-9df1b23f5701?crop=entropy&cs=srgb&fm=jpg&ixid=MnwyNzU2MDJ8MHwxfHNlYXJjaHwxfHxkZW52ZXIlMkNjb3xlbnwwfDB8fHwxNjM2OTE2MzA2&ixlib=rb-1.2.1&q=85')
    expect(@background.credit).to   be_a(Hash)
  end

  describe '#get_credit(data)' do
    it 'gets the credit info' do
      photographer = @data[:user]
      credits      = @background.get_credit(photographer)

      expect(credits).to have_key(:source)
      expect(credits[:source]).to eq('Unsplash')

      expect(credits).to have_key(:source_url)
      expect(credits[:source_url]).to eq('https://unsplash.com/?utm_source=weather_sweater&utm_medium=referral')

      expect(credits).to have_key(:photographer)
      expect(credits[:photographer]).to eq('Dillon Wanner')

      expect(credits).to have_key(:photographer_profile)
      expect(credits[:photographer_profile]).to eq('https://unsplash.com/@dillydallying?utm_source=weather_sweater&utm_medium=referral')
    end
  end
end
