class Api::V1::ActivitiesController < ApplicationController
  def index
    geo      = MapquestFacade.get_geolocation(params[:destination])
    forecast = OpenWeatherFacade.get_forecast({lat: geo[:lat], lon: geo[:lng]})
    activities = ActivitiesFacade.get_activities(forecast)

    render json: ActivitiesSerializer.format_activities(params[:destination], forecast, activities), status: :ok
  end
end
