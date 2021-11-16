require 'rails_helper'

RSpec.describe 'Road Trip Api', type: :request do
  before(:each) do
    @user = User.create!(email: 'bigboy@email.com', password: 'potato', password_confirmation: 'potato', api_key: User.generate_api_key)
  end

  it 'responds with a route', :vcr do
    params  = {
      origin: "Denver,CO",
      destination: "Pueblo,CO",
      api_key: @user.api_key
    }
    headers = { "CONTENT_TYPE" => "application/json", "Accept" => "application/json" }

    post('/api/v1/road_trip', headers: headers, params: JSON.generate(params))

    expect(response).to be_successful
    expect(response.status).to eq(200)

    body = JSON.parse(response.body, symbolize_names: true)

    expect(body).to                                      have_key(:data)
    expect(body[:data]).to                               have_key(:id)
    expect(body[:data]).to                               have_key(:type)
    expect(body[:data]).to                               have_key(:attributes)
    expect(body[:data][:attributes]).to                  have_key(:start_city)
    expect(body[:data][:attributes]).to                  have_key(:end_city)
    expect(body[:data][:attributes]).to                  have_key(:travel_time)
    expect(body[:data][:attributes]).to                  have_key(:weather_at_eta)
    expect(body[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
    expect(body[:data][:attributes][:weather_at_eta]).to have_key(:conditions)

    expect(body[:data][:attributes]).to                                be_a(Hash)
    expect(body[:data][:attributes][:start_city]).to                   be_a(String)
    expect(body[:data][:attributes][:end_city]).to                     be_a(String)
    expect(body[:data][:attributes][:travel_time]).to                  be_a(String)
    expect(body[:data][:attributes][:weather_at_eta]).to               be_a(Hash)
    expect(body[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
    expect(body[:data][:attributes][:weather_at_eta][:conditions]).to  be_a(String)
  end
end
# {
#   "data": {
#     "id": null,
#     "type": "roadtrip",
#     "attributes": {
#       "start_city": "Denver, CO",
#       "end_city": "Estes Park, CO",
#       "travel_time": "2 hours, 13 minutes"
#       "weather_at_eta": {
#         "temperature": 59.4,
#         "conditions": "partly cloudy with a chance of meatballs"
#       }
#     }
#   }
# }


# a data attribute, under which all other attributes are present:
# id, always set to null
# type, always set to “roadtrip”
# attributes, an object containing road trip information:
# start_city, string, such as “Denver, CO”
# end_city, string, such as “Estes Park, CO”
# travel_time, string, something user-friendly like “2 hours, 13 minutes” or “2h13m” or “02:13:00” or something of that nature (you don’t have to include seconds); set this string to “impossible route” if there is no route between your cities
# weather_at_eta, conditions at end_city when you arrive (not CURRENT weather), object containing:
# temperature, numeric value in Fahrenheit
# conditions, string, as given by OpenWeather
# note: this object will be blank if the travel time is impossible
# eg:
#
