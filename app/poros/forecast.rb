class Forecast
  attr_reader :id,
              :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(data)
    @id              = nil
    @current_weather = CurrentForecast.new(data[:current])
    @daily_weather   = create_daily_forecasts(data[:daily])
    @hourly_weather  = create_hourly_forecasts(data[:hourly])
  end

  def create_daily_forecasts(data)
    i = 0
    daily = []
    5.times do |i|
      daily << DailyForecast.new(data[i])
    end
    daily
  end

  def create_hourly_forecasts(data)
    i = 0
    hourly = []
    8.times do |i|
      hourly << HourlyForecast.new(data[i])
    end
    hourly
  end
end
