# Weather-Sweater

## Table of contents
- [Overview](#overview)
- [Endpoints](#endpoints)
- [APIs](#apis)
- [Setup](#setup)
- [Technologies](#technologies)
- [Contact me](#contact_me)

### Overview

This project is the backend of a hypothetical service-oriented project that allows users to make various searches about weather and locations, in addition to planning a trip. A number of working endpoints are listed below.

### APIs

The following are a list of APIs used:

[MapQuest Geocoding API](https://developer.mapquest.com/documentation/geocoding-api/)

[MapQuest Directions API](https://developer.mapquest.com/documentation/directions-api/)

[OpenWeather One Call API](https://openweathermap.org/api/one-call-api)

[Unsplash](https://unsplash.com/developers)

### Setup

Clone the repository and begin by running the following. (Please check below for correct environment versions.)

`bundle install`

Install Figaro:

`bundle exec figaro install`

You'll need to obtain api keys above and place them in your `config/application.yml` file:

```
mapquest_key: <YOUR KEY>
open_weather_key: <YOUR KEY>
unsplash_key: <YOUR KEY>
```

Please also follow setup instructions for [Webmock](https://github.com/webmock/webmock) and [VCR](https://github.com/vcr/vcr).

After all installations, run

`rails s`

to see your server working.


### Endpoints

#### Get forecast for a city

`GET /api/v1/forecast?location=<CITY>`

Example search:

`GET /api/v1/forecast?location=Denver,CO`

Example JSON response:

```
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "datetime": "2021-11-16 18:54:42 -0700",
                "sunrise": "2021-11-16 06:46:09 -0700",
                "sunset": "2021-11-16 16:43:41 -0700",
                "temperature": 55.74,
                "feels_like": 52.2,
                "humidity": 25,
                "uvi": 0,
                "visibility": 10000,
                "conditions": "broken clouds",
                "icon": "04n"
            },
            "daily_weather": [
                {
                    "date": "2021-11-16",
                    "sunrise": "2021-11-16 06:46:09 -0700",
                    "sunset": "2021-11-16 16:43:41 -0700",
                    "max_temp": 68.11,
                    "min_temp": 48.58,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },
                {
                    "date": "2021-11-17",
                    "sunrise": "2021-11-17 06:47:17 -0700",
                    "sunset": "2021-11-17 16:42:57 -0700",
                    "max_temp": 42.98,
                    "min_temp": 34.63,
                    "conditions": "broken clouds",
                    "icon": "04d"
                },
                {
                    "date": "2021-11-18",
                    "sunrise": "2021-11-18 06:48:26 -0700",
                    "sunset": "2021-11-18 16:42:16 -0700",
                    "max_temp": 49.24,
                    "min_temp": 32.27,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "date": "2021-11-19",
                    "sunrise": "2021-11-19 06:49:34 -0700",
                    "sunset": "2021-11-19 16:41:36 -0700",
                    "max_temp": 61.65,
                    "min_temp": 43.93,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },
                {
                    "date": "2021-11-20",
                    "sunrise": "2021-11-20 06:50:41 -0700",
                    "sunset": "2021-11-20 16:40:58 -0700",
                    "max_temp": 58.75,
                    "min_temp": 44.8,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                }
            ],
            "hourly_weather": [
                {
                    "time": "18:00:00",
                    "temperature": 56.34,
                    "conditions": "broken clouds",
                    "icon": "04n"
                },
                {
                    "time": "19:00:00",
                    "temperature": 55.74,
                    "conditions": "broken clouds",
                    "icon": "04n"
                },
                {
                    "time": "20:00:00",
                    "temperature": 55.65,
                    "conditions": "broken clouds",
                    "icon": "04n"
                },
                {
                    "time": "21:00:00",
                    "temperature": 54.72,
                    "conditions": "scattered clouds",
                    "icon": "03n"
                },
                {
                    "time": "22:00:00",
                    "temperature": 51.62,
                    "conditions": "scattered clouds",
                    "icon": "03n"
                },
                {
                    "time": "23:00:00",
                    "temperature": 48.58,
                    "conditions": "scattered clouds",
                    "icon": "03n"
                },
                {
                    "time": "00:00:00",
                    "temperature": 42.98,
                    "conditions": "clear sky",
                    "icon": "01n"
                },
                {
                    "time": "01:00:00",
                    "temperature": 39.74,
                    "conditions": "clear sky",
                    "icon": "01n"
                }
            ]
        }
    }
}
```

#### Get a background image for a city

`GET /api/v1/backgrounds?location=<CITY>`

Example search:

`GET /api/v1/backgrounds?location=denver,co`

Example JSON response:

```
{
    "data": {
        "id": null,
        "type": "background",
        "attributes": {
            "location": "denver,co",
            "url": "https://images.unsplash.com/photo-1634507307973-9df1b23f5701?crop=entropy&cs=srgb&fm=jpg&ixid=MnwyNzU2MDJ8MHwxfHNlYXJjaHwxfHxkZW52ZXIlMkNjb3xlbnwwfDB8fHwxNjM3MTE0Mjk0&ixlib=rb-1.2.1&q=85",
            "credit": {
                "source": "Unsplash",
                "source_url": "https://unsplash.com/?utm_source=weather_sweater&utm_medium=referral",
                "photographer": "Dillon Wanner",
                "photographer_profile": "https://unsplash.com/@dillydallying?utm_source=weather_sweater&utm_medium=referral"
            }
        }
    }
}
```

#### Register a user

`POST /api/v1/users`

Users can be posted via JSON body in your request:

```
{
  "email": "wowee@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```

Example JSON response:

```
{
  "data": {
    "id": "4",
    "type": "users",
    "attributes": {
      "email": "wowee@example.com",
      "api_key": "xxxxxxxxxxxxxxxxxxx"
    }
  }
}
```

#### Login a user

`POST /api/v1/sessions`

Users can be posted via JSON body in your request:

```
{
  "email": "wowee@example.com",
  "password": "password"
}
```

Example JSON Response:

```
{
    "data": {
        "id": "4",
        "type": "users",
        "attributes": {
            "email": "wowee@example.com",
            "api_key": "xxxxxxxxxxxxxxxxxx"
        }
    }
}
```


#### Make a road trip

`POST /api/v1/road_trip`

Users can be posted via JSON body in your request:

```
{
  "origin": "new york,ny",
  "destination": "los angeles,ca",
  "api_key": "xxxxxxxxxxxxxxxxxxxxx"
}

```

Example JSON Response:

```
{
    "data": {
        "id": null,
        "type": "road_trip",
        "attributes": {
            "start_city": "New York, NY",
            "end_city": "Los Angeles, CA",
            "travel_time": "40:16:00",
            "weather_at_eta": {
                "temperature": 65.16,
                "conditions": "overcast clouds"
            }
        }
    }
}
```

### Technologies

#### Versions
- Ruby 2.7.2
- Rails 5.2.5

#### Development
![Ruby on Rails][ruby-on-rails-badge]
![Git][git-badge]
![Atom][atom-badge]
![Faraday][faraday-badge]
![Figaro][figaro-badge]
![Postico][postico-badge]
![Postman][postman-badge]
![Rubocop][rubocop-badge]

#### Languages
![Ruby][ruby-badge]
![ActiveRecord][activerecord-badge]

#### Testing
![RSpec][rspec-badge]
![Simplecov][simplecov-badge]
![VCR][vcr-badge]
![Webmock][webmock-badge]
![Pry][pry-badge]
![Capybara][capybara-badge]
![Shoulda Matchers][shoulda-matchers-badge]

#### Development Principles
![OOP][oop-badge]
![TDD][tdd-badge]
![MVC][mvc-badge]
![REST][rest-badge]


### Contact me:
[![Build Status][travis-image]][travis-url]
[!LinkedIn][linkedin-badge](https://www.linkedin.com/in/michael-p-mattson/)

[!GitHub][github-badge](https://github.com/michaelpmattson)



<!-- Markdown link & img dfn's -->
<!-- [travis-image]:           
[travis-url]:              -->

[linkedin-badge]:         https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white
[github-badge]:           https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white

[atom-badge]:             https://img.shields.io/badge/Atom-66595C.svg?&style=flaste&logo=atom&logoColor=white
[bootstrap-badge]:        https://img.shields.io/badge/Bootstrap-563D7C?style=flat&logo=bootstrap&logoColor=white
[figaro-badge]:           https://img.shields.io/badge/figaro-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[git-badge]:              https://img.shields.io/badge/Git-F05032.svg?&style=flaste&logo=git&logoColor=white
[github-badge]:           https://img.shields.io/badge/GitHub-181717.svg?&style=flaste&logo=github&logoColor=white
[markdown-badge]:         https://img.shields.io/badge/Markdown-000000?style=flat&logo=markdown&logoColor=white
[postgreSQL-badge]:       https://img.shields.io/badge/PostgreSQL-4169E1.svg?&style=flaste&logo=postgresql&logoColor=white
[postico-badge]:          https://img.shields.io/badge/postico-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[postman-badge]:          https://img.shields.io/badge/Postman-FF6C37?style=flat&logo=Postman&logoColor=white
[rubocop-badge]:          https://img.shields.io/badge/rubocop-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[ruby-on-rails-badge]:    https://img.shields.io/badge/Ruby%20On%20Rails-b81818.svg?&style=flat&logo=rubyonrails&logoColor=white

<!-- Languages -->
[activerecord-badge]:     https://img.shields.io/badge/ActiveRecord-CC0000.svg?&style=flaste&logo=rubyonrails&logoColor=white
[css3-badge]:             https://img.shields.io/badge/CSS3-1572B6.svg?&style=flaste&logo=css3&logoColor=white
[html5-badge]:            https://img.shields.io/badge/HTML5-0EB201.svg?&style=flaste&logo=html5&logoColor=white
[ruby-badge]:             https://img.shields.io/badge/Ruby-CC0000.svg?&style=flaste&logo=ruby&logoColor=white

<!-- Deployment -->
[heroku-badge]:           https://img.shields.io/badge/Heroku-430098.svg?&style=flaste&logo=heroku&logoColor=white
[travis-ci-badge]:        https://badgen.net/badge/icon/travis?icon=travis&label
[faraday-badge]:          https://img.shields.io/badge/faraday-b81818.svg?&style=flaste&logo=rubygems&logoColor=white


<!-- Testing -->
[capybara-badge]:         https://img.shields.io/badge/capybara-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[launchy-badge]:          https://img.shields.io/badge/launchy-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[pry-badge]:              https://img.shields.io/badge/pry-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[rspec-badge]:            https://img.shields.io/badge/rspec-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[shoulda-matchers-badge]: https://img.shields.io/badge/shoulda--matchers-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[simplecov-badge]:        https://img.shields.io/badge/simplecov-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[vcr-badge]:              https://img.shields.io/badge/vcr-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[webmock-badge]:          https://img.shields.io/badge/webmock-b81818.svg?&style=flaste&logo=rubygems&logoColor=white

<!-- Development Principles -->
[oop-badge]:              https://img.shields.io/badge/OOP-b81818.svg?&style=flaste&logo=OOP&logoColor=white
[tdd-badge]:              https://img.shields.io/badge/TDD-b87818.svg?&style=flaste&logo=TDD&logoColor=white
[mvc-badge]:              https://img.shields.io/badge/MVC-b8b018.svg?&style=flaste&logo=MVC&logoColor=white
[rest-badge]:             https://img.shields.io/badge/REST-33b818.svg?&style=flaste&logo=REST&logoColor=white
