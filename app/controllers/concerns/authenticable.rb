module Authenticable
  extend ActiveSupport::Concern

  def current_user
    @current_user ||= Auth::JwtDecoder.call(request.headers['HTTP_AUTHORIZATION'])
  end

  private

  def auth_token
    request.headers['Authorization']&.split&.last
  end
end
