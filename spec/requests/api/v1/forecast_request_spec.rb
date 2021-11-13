require 'rails_helper'

RSpec.describe 'Forecast API' do
  it 'gets a forecast for a given address' do
    get('/api/v1/forecast?location=denver,co')

    expect(response).to be_successful
  end
end


#
# Content-Type: application/json
# Accept: application/json
# Response:
#
# The response data should contain exactly these elements and nothing more:
#
# a data attribute, under which all other attributes are present:
# id, always set to null
# type, always set to “forecast”
# attributes, an object containing weather information:
# current_weather, holds current weather data:
# datetime, in a human-readable format such as “2020-09-30 13:27:03 -0600”
# sunrise, in a human-readable format such as “2020-09-30 06:27:03 -0600”
# sunset, in a human-readable format such as “2020-09-30 18:27:03 -0600”
# temperature, floating point number indicating the current temperature in Fahrenheit
# feels_like, floating point number indicating a temperature in Fahrenheit
# humidity, numeric (int or float), as given by OpenWeather
# uvi, numeric (int or float), as given by OpenWeather
# visibility, numeric (int or float), as given by OpenWeather
# conditions, the first ‘description’ field from the weather data as given by OpenWeather
# icon, string, as given by OpenWeather
# daily_weather, array of the next 5 days of daily weather data:
# date, in a human-readable format such as “2020-09-30”
# sunrise, in a human-readable format such as “2020-09-30 06:27:03 -0600”
# sunset, in a human-readable format such as “2020-09-30 18:27:03 -0600”
# max_temp, floating point number indicating the maximum expected temperature in Fahrenheit
# min_temp, floating point number indicating the minimum expected temperature in Fahrenheit
# conditions, the first ‘description’ field from the weather data as given by OpenWeather
# icon, string, as given by OpenWeather
# hourly_weather, array of the next 8 hours of hourly weather data:
# time, in a human-readable format such as “14:00:00”
# temperature, floating point number indicating the current temperature in Fahrenheit
# conditions, the first ‘description’ field from the weather data as given by OpenWeather
# icon, string, as given by OpenWeather
# Example:
#
# {
#   "data": {
#     "id": null,
#     "type": "forecast",
#     "attributes": {
#       "current_weather": {
#         "datetime": "2020-09-30 13:27:03 -0600",
#         "temperature": 79.4,
#         etc
#       },
#       "daily_weather": [
#         {
#           "date": "2020-10-01",
#           "sunrise": "2020-10-01 06:10:43 -0600",
#           etc
#         },
#         {...} etc
#       ],
#       "hourly_weather": [
#         {
#           "time": "14:00:00",
#           "conditions": "cloudy with a chance of meatballs",
#           etc
#         },
#         {...} etc
#       ]
#     }
#   }
# }
