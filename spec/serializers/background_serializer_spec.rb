require 'rails_helper'

RSpec.describe BackgroundSerializer do
  before(:each) do
    background_data = File.read('spec/fixtures/denver_background_response.json')
    background_hash = JSON.parse(background_data, symbolize_names: true)[:results].first
    background      = Background.new(background_hash, 'denver,co')
    @serialized     = BackgroundSerializer.new(background).serializable_hash
  end

  it 'serializes background object into json' do
    expect(@serialized).to be_a(Hash)

    expect(@serialized).to have_key(:data)

    expect(@serialized[:data]).to have_key(:id)
    expect(@serialized[:data]).to have_key(:type)
    expect(@serialized[:data]).to have_key(:attributes)

    expect(@serialized[:data][:id]).to         be_nil
    expect(@serialized[:data][:type]).to       eq(:background)
    expect(@serialized[:data][:attributes]).to be_a(Hash)


    expect(@serialized[:data][:attributes]).to have_key(:location)
    expect(@serialized[:data][:attributes]).to have_key(:url)
    expect(@serialized[:data][:attributes]).to have_key(:credit)

    expect(@serialized[:data][:attributes][:location]).to be_a(String)
    expect(@serialized[:data][:attributes][:url]).to      be_a(String)
    expect(@serialized[:data][:attributes][:credit]).to   be_a(Hash)

    expect(@serialized[:data][:attributes][:credit]).to have_key(:source)
    expect(@serialized[:data][:attributes][:credit]).to have_key(:source_url)
    expect(@serialized[:data][:attributes][:credit]).to have_key(:photographer)
    expect(@serialized[:data][:attributes][:credit]).to have_key(:photographer_profile)

    expect(@serialized[:data][:attributes][:credit][:source]).to               be_a(String)
    expect(@serialized[:data][:attributes][:credit][:source_url]).to           be_a(String)
    expect(@serialized[:data][:attributes][:credit][:photographer]).to         be_a(String)
    expect(@serialized[:data][:attributes][:credit][:photographer_profile]).to be_a(String)
  end
end
