class Background
  attr_reader :id,
              :location,
              :url,
              :credit

  def initialize(data, location)
    @id       = nil
    @location = location
    @url      = data[:urls][:full]
    @credit   = get_credit(data[:user])
  end

  def get_credit(data)
    {
      source: 'Unsplash',
      source_url: 'https://unsplash.com/?utm_source=weather_sweater&utm_medium=referral',
      photographer: data[:name],
      photographer_profile: "#{data[:links][:self]}?utm_source=weather_sweater&utm_medium=referral"
    }
  end
end
