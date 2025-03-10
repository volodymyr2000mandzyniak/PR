class ApplicationController < ActionController::API
  include ErrorHandler
  before_action :authenticate_user!, unless: :devise_controller?
end
