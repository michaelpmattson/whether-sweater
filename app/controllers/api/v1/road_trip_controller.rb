class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      road_trip = RoadTripFacade.get_road_trip(road_trip_params)
      render json: RoadTripSerializer.new(road_trip), status: :ok
    else
      render json: { error: 'Valid api key required.' }, status: :unauthorized
    end
  end

  private

  def road_trip_params
    params.require(:road_trip).permit(:origin, :destination)
  end
end
