class ForecastSerializer
  def self.format_forecast(forecast)
    {
      data: {
        id: nil,
        type: 'forecast',
        attributes: {
          current_weather: {
            datetime:    forecast.current_weather.datetime,
            sunrise:     forecast.current_weather.sunrise,
            sunset:      forecast.current_weather.sunset,
            temperature: forecast.current_weather.temperature,
            feels_like:  forecast.current_weather.feels_like,
            humidity:    forecast.current_weather.humidity,
            uvi:         forecast.current_weather.uvi,
            visibility:  forecast.current_weather.visibility,
            conditions:  forecast.current_weather.conditions,
            icon:        forecast.current_weather.icon
          },
          daily_weather: forecast.daily_weather.map do |d|
            {
              date:       d.date,
              sunrise:    d.sunrise,
              sunset:     d.sunset,
              max_temp:   d.max_temp,
              min_temp:   d.min_temp,
              conditions: d.conditions,
              icon:       d.icon
            }
          end,
          hourly_weather: forecast.hourly_weather.map do |h|
            {
              time:        h.time,
              temperature: h.temperature,
              conditions:  h.conditions,
              icon:        h.icon
            }
          end
        }
      }
    }
  end
end
