require 'rails_helper'

RSpec.describe 'POST /api/v1/road_trip', type: :request do
  before(:each) do
    @user = User.create!(email: 'bigboy@email.com', password: 'potato', password_confirmation: 'potato', api_key: User.generate_api_key)
  end

  it 'responds with a route' do
    params  = {
      origin: "Denver,CO",
      destination: "Pueblo,CO",
      api_key: @user.api_key
    }
    headers = { "CONTENT_TYPE" => "application/json", "Accept" => "application/json" }

    post('/api/v1/road_trip', headers: headers, params: JSON.generate(params))

    expect(response).to be_successful
    expect(response.status).to eq(200)
  end
end
