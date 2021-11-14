class Api::V1::BackgroundsController < ApplicationController
  def index
    if params[:location].nil?
      render json: { error: 'location required' }, status: 400
    else
      background = BackgroundFacade.get_background(params[:location])
      render json: BackgroundSerializer.new(background)
    end
  end
end
