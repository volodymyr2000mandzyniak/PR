# app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController
  include RackSessionsFix
  skip_before_action :verify_signed_out_user, only: [:destroy]
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render json: {
      status: { code: 200, message: 'Logged in successfully.' },
      data: { user: resource }
    }, status: :ok
  end

  def respond_to_on_destroy
    if request.headers['Authorization'].present?
      token = request.headers['Authorization'].split(' ').last

      begin
        jwt_payload = JWT.decode(token, Rails.application.credentials.devise_jwt_secret_key!).first
        current_user = User.find(jwt_payload['sub'])

        if current_user
          current_user.update(jti: SecureRandom.uuid)
          render json: {
            status: 200,
            message: 'Logged out successfully.'
          }, status: :ok
        else
          render json: {
            status: 401,
            message: "User not found."
          }, status: :unauthorized
        end
      rescue JWT::DecodeError => e
        render json: {
          status: 401,
          message: "Invalid token: #{e.message}"
        }, status: :unauthorized
      rescue ActiveRecord::RecordNotFound
        render json: {
          status: 401,
          message: "User not found."
        }, status: :unauthorized
      end
    else
      render json: {
        status: 401,
        message: "Authorization header is missing."
      }, status: :unauthorized
    end
  end
end