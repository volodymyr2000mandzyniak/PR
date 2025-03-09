class ApplicationController < ActionController::API
  include ErrorHandler
  before_action :authenticate_user!, unless: :devise_controller?

  # include ActionController::HttpAuthentication::Token::ControllerMethods
  # before_action :authenticate_user_from_token!

  # protected

  # def authenticate_user_from_token!
  #   authenticate_with_http_token do |token, options|
  #     user = User.find_by(authentication_token: token)
  #     if user
  #       sign_in user, store: false
  #     else
  #       render json: { error: 'Unauthorized' }, status: :unauthorized
  #     end
  #   end
  # end
end
