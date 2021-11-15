require 'rails_helper'

RSpec.describe 'User registration', type: :request do
  describe 'POST /api/v1/users' do
    it 'authenticates the client' do
      post('/api/v1/users', params: { email: 'bigboy@email.com', password: 'potato', password_confirmation: 'potato'})

      expect(response).to be_successful
      expect(response.status).to eq(201)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body).to        have_key(:data)

      expect(body[:data]).to be_a(Hash)
      expect(body[:data]).to have_key(:type)
      expect(body[:data]).to have_key(:id)
      expect(body[:data]).to have_key(:attributes)

      expect(body[:data][:type]).to       eq('users')
      expect(body[:data][:id]).to         be_a(String)
      expect(body[:data][:attributes]).to be_a(Hash)

      expect(body[:data][:attributes]).to     have_key(:email)
      expect(body[:data][:attributes]).to     have_key(:api_key)
      expect(body[:data][:attributes]).to_not have_key(:password)
      expect(body[:data][:attributes]).to_not have_key(:password_confirmation)
      expect(body[:data][:attributes]).to_not have_key(:password_digest)

      expect(body[:data][:attributes][:email]).to eq('bigboy@email.com')
      expect(body[:data][:attributes][:api_key]).to be_a(String)
      expect(body[:data][:attributes][:api_key].length).to eq(22)
    end

    it 'requires all fields' do
      post('/api/v1/users', params: { email: '', password: 'potato', password_confirmation: 'potato'})

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:error]).to eq('all fields must have values')

      post('/api/v1/users', params: { email: 'bigboy@email.com', password: '', password_confirmation: 'potato'})

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:error]).to eq('all fields must have values')

      post('/api/v1/users', params: { email: 'bigboy@email.com', password: 'potato', password_confirmation: ''})

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:error]).to eq('all fields must have values')
    end

    it 'requires password and password_confirmation to be same' do
      post('/api/v1/users', params: { email: 'bigboy@email.com', password: 'potato', password_confirmation: 'tomato'})

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:error]).to eq('password and password confirmation must be same')
    end

    it 'cannot makew two users with same email' do
      post('/api/v1/users', params: { email: 'bigboy@email.com', password: 'potato', password_confirmation: 'potato'})

      expect(response).to be_successful

      post('/api/v1/users', params: { email: 'bigboy@email.com', password: 'tomato', password_confirmation: 'tomato'})

      expect(response).to_not be_successful
      expect(response.status).to eq(403)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:error]).to eq('email has already been used')
    end
  end
end
