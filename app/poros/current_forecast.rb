class CurrentForecast
  include Convertable

  attr_reader :datetime,
              :sunrise,
              :sunset,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :conditions,
              :icon

  def initialize(data)
    @datetime    = unix_to_readable_datetime(data[:dt])
    @sunrise     = unix_to_readable_datetime(data[:sunrise])
    @sunset      = unix_to_readable_datetime(data[:sunset])
    @temperature = data[:temp]
    @feels_like  = data[:feels_like]
    @humidity    = data[:humidity]
    @uvi         = data[:uvi]
    @visibility  = data[:visibility]
    @conditions  = data[:weather].first[:description]
    @icon        = data[:weather].first[:icon]
  end
end
