class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(user_id)
    JWT.encode({user_id: user_id}, "12345")
  end

  def get_token
    request.headers["Authorization"]
  end

  def decode_token
    begin
      JWT.decode(get_token, "12345")[0]["user_id"]
    rescue
      # token invalid, return nil
      nil
    end
  end

  def current_user
    User.find_by(id: decode_token)
  end

end
