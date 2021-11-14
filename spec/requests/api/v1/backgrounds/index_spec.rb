require 'rails_helper'

RSpec.describe 'Backgrounds API' do
  it 'gets a forecast for a given address', :vcr do
    get('/api/v1/backgrounds?location=denver,co')

    expect(response).to be_successful

    # data = JSON.parse(response.body, symbolize_names: true)
  end

  it 'returns a 400 response if no param is entered', :vcr do
    get('/api/v1/backgrounds?location')

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
  end
end
