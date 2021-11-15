require 'rails_helper'

RSpec.describe ActivitiesFacade, type: :facade do
  before(:each) do
    response = File.read('spec/fixtures/denver_weather_example.json')
    @data     = JSON.parse(response, symbolize_names: true)
  end

  describe '.get_activities(forecast)' do
    it 'gets a relaxation and recreational when temp is > 60', :vcr do
      @data[:current][:temp] = 61

      forecast    = Forecast.new(@data)
      activities  = ActivitiesFacade.get_activities(forecast)

      expect(activities).to have_key(:relaxation)
      expect(activities).to have_key(:other)

      expect(activities[:relaxation].type).to eq('relaxation')
      expect(activities[:other].type).to      eq('recreational')
    end

    it 'gets a relaxation and busywork when temp is >= 50 but < 60', :vcr do
      @data[:current][:temp] = 51

      forecast    = Forecast.new(@data)
      activities  = ActivitiesFacade.get_activities(forecast)

      expect(activities).to have_key(:relaxation)
      expect(activities).to have_key(:other)

      expect(activities[:relaxation].type).to eq('relaxation')
      expect(activities[:other].type).to      eq('busywork')

      @data[:current][:temp] = 50

      forecast    = Forecast.new(@data)
      activities  = ActivitiesFacade.get_activities(forecast)

      expect(activities).to have_key(:relaxation)
      expect(activities).to have_key(:other)

      expect(activities[:relaxation].type).to eq('relaxation')
      expect(activities[:other].type).to      eq('busywork')
    end

    it 'gets a relaxation and cooking when temp is < 50 (else)', :vcr do
      @data[:current][:temp] = 49

      forecast    = Forecast.new(@data)
      activities  = ActivitiesFacade.get_activities(forecast)

      expect(activities).to have_key(:relaxation)
      expect(activities).to have_key(:other)

      expect(activities[:relaxation].type).to eq('relaxation')
      expect(activities[:other].type).to      eq('cooking')
    end
  end
end
