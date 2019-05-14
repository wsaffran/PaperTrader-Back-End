class AuthController < ApplicationController

  def login
    user = User.find_by(username: params[:username])


    if user && user.authenticate(params[:password])
      token = encode_token(user.id)
      render json: {user: user, token: token} #user: UserSerializer.new(user)
    else
      render json: {errors: "user does not exist or wrong logins"}
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

end
