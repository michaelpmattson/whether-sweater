require 'rails_helper'

RSpec.describe ActivitiesSerializer do
  before(:each) do
    destination   = 'denver,co'
    forecast_data = File.read('spec/fixtures/denver_weather_example.json')
    forecast_hash = JSON.parse(forecast_data, symbolize_names: true)
    forecast      = Forecast.new(forecast_hash)
    relaxation    = {:activity=>"Give your pet ten minutes of focused attention", :type=>"relaxation", :participants=>1, :price=>0, :link=>"", :key=>"9937387", :accessibility=>0}
    other         = {:activity=>"Learn and play a new card game", :type=>"recreational", :participants=>1, :price=>0, :link=>"https://www.pagat.com", :key=>"9660022", :accessibility=>0}
    activities    = { relaxation: Activity.new(relaxation), other: Activity.new(other) }
    @serialized   = ActivitiesSerializer.format_activities(destination, forecast, activities)
  end

  it 'serializes activities into json' do
    expect(@serialized).to        have_key(:data)

    expect(@serialized[:data]).to have_key(:id)
    expect(@serialized[:data]).to have_key(:type)
    expect(@serialized[:data]).to have_key(:attributes)

    expect(@serialized[:data][:id]).to         be_nil
    expect(@serialized[:data][:type]).to       eq('activities')
    expect(@serialized[:data][:attributes]).to be_a(Hash)

    expect(@serialized[:data][:attributes]).to have_key(:destination)
    expect(@serialized[:data][:attributes]).to have_key(:forecast)
    expect(@serialized[:data][:attributes]).to have_key(:activities)

    expect(@serialized[:data][:attributes][:destination]).to eq('denver,co')
    expect(@serialized[:data][:attributes][:forecast]).to    be_a(Hash)
    expect(@serialized[:data][:attributes][:activities]).to  be_an(Array)

    expect(@serialized[:data][:attributes][:forecast]).to have_key(:summary)
    expect(@serialized[:data][:attributes][:forecast]).to have_key(:temperature)

    expect(@serialized[:data][:attributes][:forecast][:summary]).to     be_a(String)
    expect(@serialized[:data][:attributes][:forecast][:temperature]).to be_a(String)

    @serialized[:data][:attributes][:activities].each do |activity|
      expect(activity).to be_a(Hash)
      expect(activity.keys[0]).to be_a(String)
      expect(activity.values[0]).to be_a(Hash)

      expect(activity.values[0]).to have_key(:type)
      expect(activity.values[0]).to have_key(:participants)
      expect(activity.values[0]).to have_key(:price)

      expect(activity.values[0][:type]).to be_a(String)
      expect(activity.values[0][:participants]).to be_a(Integer)
      expect(activity.values[0][:price]).to be_a(Float).or be_an(Integer)
    end
  end
end
