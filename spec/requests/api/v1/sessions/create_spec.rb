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

  it 'gives a 400 response for bad info' do
    post('/api/v1/sessions', params: { email: 'bigboy@zmail.com', password: 'potato' })

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:error]).to eq('Sorry, bad credentials.')

    post('/api/v1/sessions', params: { email: 'bigboy@email.com', password: 'zotato' })

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:error]).to eq('Sorry, bad credentials.')
  end

  it 'email is case insensitive' do
    post('/api/v1/sessions', params: { email: 'BIGBOY@EMAIL.COM', password: 'potato' })

    expect(response).to be_successful
    expect(response.status).to eq(200)
  end

  it 'password is case sensitive' do
    post('/api/v1/sessions', params: { email: 'BIGBOY@EMAIL.COM', password: 'POTATP' })

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
  end
end
