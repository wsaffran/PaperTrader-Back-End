class UsersController < ApplicationController

  def index
    users = User.all

    render json: users, each_serializer: UserSerializer
  end

  def create
    user = User.create(user_params)

    if user.valid?
      token = encode_token(user_id: user.id)
      render json: {user: UserSerializer.new(user), token: token}, status: :created
    else
      render json: {error: "failed to create user"}, status: :not_acceptable
    end
  end

  def user_params
    params.require(:user).permit(:username, :first_name, :last_name, :password, :avatar_url)
  end

end
