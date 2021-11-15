class ActivityService < ApplicationService
  def self.get_activity_by_type(type)
    response = conn.get("http://www.boredapi.com/api/activity?type=#{type}")
    parse_json(response)
  end

  private

  def self.conn
    Faraday.new(url: 'http://www.boredapi.com')
  end
end
