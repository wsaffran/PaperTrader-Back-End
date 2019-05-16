class AuthController < ApplicationController
  skip_before_action :authorized, only: [:login]

  def login # POST /login
    user = User.find_by(username: user_login_params[:username])

    if user && user.authenticate(user_login_params[:password])
      token = encode_token(user_id: user.id)
      render json: {user: UserSerializer.new(user), token: token}, status: :accepted
    else
      render json: {errors: "user does not exist or wrong logins"}, status: :unauthorized
    end
  end

  def auto_login
    if current_user
      render json: current_user
    else
      render json: {errors: "could not login"}
    end
  end

  def signup
    user = User.create(first_name: params[:firstName], last_name: params[:lastName], username: params[:username], password: params[:password])

    render json: user
  end

  private

  def user_login_params
    params.require(:user).permit(:username, :password)
  end

end
