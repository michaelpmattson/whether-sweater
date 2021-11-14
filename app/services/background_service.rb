class BackgroundService < ApplicationService
  def self.get_background_data(location)
    response = conn.get("search/photos?page=1&per_page=1&orientation=landscape&query=#{location}")
    parse_json(response)
  end

  private

  def self.conn
    Faraday.new(url: 'https://api.unsplash.com') do |faraday|
      faraday.headers['Authorization'] = "Client-ID #{ENV['unsplash_key']}"
    end
  end
end
