class DailyForecast
  include Convertable

  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon

  def initialize(data)
    @date       = unix_to_readable_date(data[:dt])
    @sunrise    = unix_to_readable_datetime(data[:sunrise])
    @sunset     = unix_to_readable_datetime(data[:sunset])
    @max_temp   = data[:temp][:max]
    @min_temp   = data[:temp][:min]
    @conditions = data[:weather].first[:description]
    @icon       = data[:weather].first[:icon]
  end
end
