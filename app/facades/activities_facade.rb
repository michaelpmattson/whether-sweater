class ActivitiesFacade
  def self.get_activities(forecast)
    relaxation = ActivityService.get_activity_by_type('relaxation')
    other = {}
    if forecast.current_temperature > 60
      other = ActivityService.get_activity_by_type('recreational')
      require "pry"; binding.pry
    elsif forecast.current_temperature >= 50
      other = ActivityService.get_activity_by_type('busywork')
    else
      other = ActivityService.get_activity_by_type('cooking')
    end

    { relaxation: Activity.new(relaxation), other: Activity.new(other) }
  end
end
