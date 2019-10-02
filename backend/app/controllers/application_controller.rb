class ApplicationController < ActionController::API


  def current_user
    @current_user
  end

  private

  def authenticate_by_fireauth!
    begin
      binding.pry
      decoded_token = FireAuthUtil.verify_id_token!(http_token)
      payload = decoded_token[:payload]
      @current_user = User.find_or_create_by!(fireauth_uid: payload["sub"])

    rescue => e
      render json: { errors: ['Not Authenticated'], message: e }, status: :unauthorized
    end
  end

  def http_token
    if request.headers['Authorization'].present?
      request.headers['Authorization'].split(' ').last
    end
  end

end
