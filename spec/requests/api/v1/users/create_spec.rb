require 'rails_helper'

RSpec.describe 'User registration', type: :request do
  describe 'POST /api/v1/users' do
    it 'authenticates the client' do
      post '/api/v1/users'
    end
  end
end
