require 'rails_helper'

RSpec.describe 'the post sessions endpoint' do
  before(:each) do
    @user = User.create!(email: 'bigboy@email.com', password: 'potato', password_confirmation: 'potato', api_key: User.generate_api_key)
  end

  it 'logs in a user and gives them their api key' do
    post('/api/v1/sessions', params: { email: 'bigboy@email.com', password: 'potato' })

    expect(response).to be_successful
    expect(response.status).to eq(200)

    body = JSON.parse(response.body, symbolize_names: true)

    expect(body).to                     have_key(:data)
    expect(body[:data]).to              have_key(:type)
    expect(body[:data]).to              have_key(:id)
    expect(body[:data]).to              have_key(:attributes)
    expect(body[:data][:attributes]).to have_key(:email)
    expect(body[:data][:attributes]).to have_key(:api_key)

    expect(body[:data]).to                        be_a(Hash)
    expect(body[:data][:type]).to                 eq('users')
    expect(body[:data][:id]).to                   eq(@user.id.to_s)
    expect(body[:data][:attributes]).to           be_a(Hash)
    expect(body[:data][:attributes][:email]).to   eq(@user.email)
    expect(body[:data][:attributes][:api_key]).to eq(@user.api_key)
  end
end

#
# status: 200
# body:
#
# {
#   "data": {
#     "type": "users",
#     "id": "1",
#     "attributes": {
#       "email": "whatever@example.com",
#       "api_key": "jgn983hy48thw9begh98h4539h4"
#     }
#   }
# }
# Requirements:
#
# This POST endpoint should NOT call your endpoint like /api/v1/sessions?email=person@woohoo.com&password=abc123, and should NOT send as form data either. You must send a JSON payload in the body of the request
# in Postman, under the address bar, click on “Body”, select “raw”, which will show a dropdown that probably says “Text” in it, choose “JSON” from the list
# this is a hard requirement to pass this endpoint!
# A successful request returns the user’s api key.
# An unsuccessful request returns an appropriate 400-level status code and body with a description of why the request wasn’t successful.
# Potential reasons a request would fail: credentials are bad, etc
# Security tip: never tell a user which field (email/password) is incorrect, as this alerts malicious users how to attack your site (eg, if they’ve guessed a correct email address, and you tell them the password is bad, then they don’t need to keep guessing email addresses, and can just try to crack the password)
