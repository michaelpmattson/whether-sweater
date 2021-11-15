require 'rails_helper'

RSpec.describe 'the post sessions endpoint' do
  before(:each) do
    @user = User.create!(email: 'bigboy@email.com', password: 'potato', password_confirmation: 'potato', api_key: User.generate_api_key)
  end

  it 'logs in a user and gives them their api key' do
    post('/api/v1/sessions', params: { email: 'bigboy@email.com', password: 'potato' })

    expect(response).to be_successful
  end
end

# Your api should expose this endpoint:
#
# Request:
#
# POST /api/v1/sessions
# Content-Type: application/json
# Accept: application/json
#
# {
#   "email": "whatever@example.com",
#   "password": "password"
# }
# Response:
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
