require 'rails_helper'

RSpec.describe 'Forecast API' do
  it 'gets a forecast for a given address', :vcr do
    get('/api/v1/forecast?location=denver,co')

    expect(response).to be_successful

    data = JSON.parse(response.body, symbolize_names: true)
  end
end
