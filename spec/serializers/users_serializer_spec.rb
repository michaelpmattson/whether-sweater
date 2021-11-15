require 'rails_helper'

RSpec.describe UsersSerializer do
  before(:each) do
    user = User.create!(email: 'bigboy@email.com', password: 'potato', password_confirmation: 'potato', api_key: User.generate_api_key)
    @serialized   = UsersSerializer.new(user).serializable_hash
  end

  it 'serializes a user' do
    expect(@serialized).to        have_key(:data)

    expect(@serialized[:data]).to be_a(Hash)
    expect(@serialized[:data]).to have_key(:type)
    expect(@serialized[:data]).to have_key(:id)
    expect(@serialized[:data]).to have_key(:attributes)

    expect(@serialized[:data][:type]).to       eq(:users)
    expect(@serialized[:data][:id]).to         be_a(String)
    expect(@serialized[:data][:attributes]).to be_a(Hash)

    expect(@serialized[:data][:attributes]).to     have_key(:email)
    expect(@serialized[:data][:attributes]).to     have_key(:api_key)
    expect(@serialized[:data][:attributes]).to_not have_key(:password)
    expect(@serialized[:data][:attributes]).to_not have_key(:password_confirmation)
    expect(@serialized[:data][:attributes]).to_not have_key(:password_digest)

    expect(@serialized[:data][:attributes][:email]).to eq('bigboy@email.com')
    expect(@serialized[:data][:attributes][:api_key]).to be_a(String)
    expect(@serialized[:data][:attributes][:api_key].length).to eq(22)
  end
end
