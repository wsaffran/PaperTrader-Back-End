class UsersController < ApplicationController

  def create
    user = User.new(
      username: params[:username]
      first_name: params[:first_name]
      last_name: params[:last_name]
      password: params[:password]
      avatar_url: "https://www.limestone.edu/sites/default/files/user-icon.png"
    )

    if user.save
      render json: user
    else
      render json: {errors: user.errors.full_messages}
  end

end
