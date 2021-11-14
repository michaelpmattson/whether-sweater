class HourlyForecast
  include Convertable

  attr_reader :time,
              :temperature,
              :conditions,
              :icon

  def initialize(data)
    @time        = unix_to_readable_time(data[:dt])
    @temperature = data[:temp]
    @conditions  = data[:weather].first[:description]
    @icon        = data[:weather].first[:icon]
  end
end
