require 'rails_helper'

RSpec.describe BackgroundFacade do
  describe '.get_background(location)', :vcr do
    it 'returns a background object' do
      location = 'denver,co'
      expect(BackgroundFacade.get_background(location)).to be_a(Background)
      binding.pry
    end
  end
end
