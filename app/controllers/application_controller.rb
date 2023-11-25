class ApplicationController < ActionController::API
  before_action :authenticate_user, except: :create

  private

  def authenticate_user
    auth_token = request.headers['Authorization']&.split(' ')&.last
    @current_user = User.find_by(auth_token: auth_token) if auth_token
    head :unauthorized unless @current_user
  end
end
