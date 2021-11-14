class BackgroundFacade
  def self.get_background(location)
    background_data = BackgroundService.get_background_data(location)[:results].first
    Background.new(background_data, location)
  end
end
