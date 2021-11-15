class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: user_params[:email].downcase)
    if user && user.authenticate(user_params[:password])
      render json: UsersSerializer.new(user), status: :ok
    else
      render json: { error: 'Sorry, bad credentials.'}, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:session).permit(:email, :password)
  end
end
