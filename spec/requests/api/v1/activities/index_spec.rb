require 'rails_helper'

RSpec.describe 'the activities endpoint' do
  it 'gets activities based on location', :vcr do
    get('/api/v1/activities?destination=chicago,il')

    expect(response).to be_successful
    expect(response.status).to eq(200)

    body = JSON.parse(response.body)

    expect(body).to        have_key('data')

    expect(body['data']).to have_key('id')
    expect(body['data']).to have_key('type')
    expect(body['data']).to have_key('attributes')

    expect(body['data']['id']).to         be_nil
    expect(body['data']['type']).to       eq('activities')
    expect(body['data']['attributes']).to be_a(Hash)

    expect(body['data']['attributes']).to have_key('destination')
    expect(body['data']['attributes']).to have_key('forecast')
    expect(body['data']['attributes']).to have_key('activities')

    expect(body['data']['attributes']['destination']).to eq('chicago,il')
    expect(body['data']['attributes']['forecast']).to    be_a(Hash)
    expect(body['data']['attributes']['activities']).to  be_an(Array)

    expect(body['data']['attributes']['forecast']).to have_key('summary')
    expect(body['data']['attributes']['forecast']).to have_key('temperature')

    expect(body['data']['attributes']['forecast']['summary']).to     be_a(String)
    expect(body['data']['attributes']['forecast']['temperature']).to be_a(String)

    body['data']['attributes']['activities'].each do |activity|
      expect(activity).to be_a(Hash)
      expect(activity.keys[0]).to be_a(String)
      expect(activity.values[0]).to be_a(Hash)

      expect(activity.values[0]).to have_key('type')
      expect(activity.values[0]).to have_key('participants')
      expect(activity.values[0]).to have_key('price')

      expect(activity.values[0]['type']).to be_a(String)
      expect(activity.values[0]['participants']).to be_a(Integer)
      expect(activity.values[0]['price']).to be_a(Float).or be_an(Integer)
    end
  end
end
# Your response should be in the format below:
# {
#   'data'": {
#     'id'": "null",
#     "type": "activities",
#     "attributes": {
#       "destination": "chicago,il",
#       "forecast": {
#         "summary": "Cloudy with a chance of meatballs",
#         "temperature": "45 F"
#       },
#       "activities": {
#         "Learn a new recipe": {
#           "type": "cooking",
#           "participants": 1,
#           "price": 0
#         },
#         "Take a bubble bath": {
#           "type": "relaxation",
#           "participants": 1,
#           "price": 0.5
#         }
#       }
#     }
#   }
# }

# Assignment:
# You will be using the Bored API to find activities once you read a destination city provided by the user. Presume that your user will give a known "good" location. (you can handle edge cases later)
# Your endpoint should follow this format:
# GET /api/v1/activities?destination=chicago,il
# please do not deviate from the names of the endpoint or query parameter, be sure it is called "activities" and "destination", respectively

# Your API will return:
# the destination city
# the forecast in that city right now


# Two activities that would be suitable given the weather:
# for all temperatures, include one relaxation activity

# if the temperature is >= 60 F, include one recreational activity.
# if the temperature is >= 50 F and < 60 F, include one busywork activity.
# if the temperature is < 50 F, include one cooking activity.

# Submission:
# Please submit your final assessment between 11:50pm and 12:00pm via this form.
