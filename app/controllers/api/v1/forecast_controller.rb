class Api::V1::ForecastController < ApplicationController
  def index
    geo      = MapquestFacade.get_geolocation(params[:location])
    forecast = OpenWeatherFacade.get_forecast({lat: geo[:lat], lon: geo[:lng]})

    render json: ForecastSerializer.format_forecast(forecast), status: :ok
  end
end
