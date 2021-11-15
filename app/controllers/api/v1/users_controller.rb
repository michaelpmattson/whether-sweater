class Api::V1::UsersController < ApplicationController
  def create
    user         = user_params
    user[:email] = user[:email].downcase
    new_user     = User.new(user)
    if missing_fields?
      render json: { error: 'all fields must have values' }, status: :bad_request
    elsif user[:password] != user[:password_confirmation]
      render json: { error: 'password and password confirmation must be same' }, status: :bad_request
    elsif new_user.save
      new_user.update(api_key: User.generate_api_key)
      render json: UsersSerializer.new(new_user), status: :created
    else
      render json: { error: 'email has already been used' }, status: :forbidden
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def missing_fields?
    user_params[:email].blank? || user_params[:password].blank? || user_params[:password_confirmation].blank?
  end
end
