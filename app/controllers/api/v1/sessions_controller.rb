class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      render json: UsersSerializer.new(user), status: :ok
    else
      render json: { error: 'Sorry, bad credentials.'}, status: :bad_request
    end
  end
end
