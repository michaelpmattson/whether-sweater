class ActivitiesSerializer
  def self.format_activities(destination, forecast, activities)
    {
      data: {
        id: nil,
        type: 'activities',
        attributes: {
          destination: destination,
          forecast: {
            summary: forecast.current_conditions,
            temperature: "#{forecast.current_temperature} F"
          },
          activities: activities.map do |type, activity|
            {
              activity.name => {
                type: activity.type,
                participants: activity.participants,
                price: activity.price
              }
            }
          end
        }
      }
    }
  end
end
