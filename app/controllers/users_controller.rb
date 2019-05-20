class UsersController < ApplicationController

  def index
    users = User.all

    render json: users, each_serializer: UserSerializer
  end

  def signup
    user = User.new(
      username: params[:username],
      first_name: params[:first_name],
      last_name: params[:last_name],
      password: params[:password],
      avatar_url: "https://www.limestone.edu/sites/default/files/user-icon.png"
    )

    if user.save
      token = encode_token(user.id)

      render json: {user: user, token: token}
    else
      render json: {errors: user.errors.full_messages}
    end
  end

  def create
    user = User.create(first_name: params[:firstName], last_name: params[:lastName], username: params[:username], password: params[:password])
    token = encode_token(user.id)
    render json: {user: user, token: token}
  end

end
