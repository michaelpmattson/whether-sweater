class ActivitiesSerializer
  def self.format_activities(destination, forecast, activities)
    {
      data: {
        id: nil,
        type: 'activities',
        attributes: {
          destination: destination,
          forecast: {
            summary: forecast.current_weather.conditions,
            temperature: "#{forecast.current_temperature} F"
          },
          activities: [
            {
              activities[:relaxation].name => {
                type: activities[:relaxation].type,
                participants: activities[:relaxation].participants,
                price: activities[:relaxation].price
              }
            },
            {
              activities[:other].name => {
                type: activities[:other].type,
                participants: activities[:other].participants,
                price: activities[:other].price
              }
            }
          ]
        }
      }
    }
  end
end
