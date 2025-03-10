# spec/requests/users/sessions_spec.rb
require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  include Devise::Test::ControllerHelpers

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  let(:user) { create(:user) }
  let(:valid_credentials) { { email: user.email, password: user.password } }
  let(:invalid_credentials) { { email: user.email, password: 'wrong_password' } }

  let(:valid_token) do
    JWT.encode(
      { sub: user.id, jti: SecureRandom.uuid },
      Rails.application.credentials.devise_jwt_secret_key!
    )
  end

  describe 'POST #create' do
    context 'with valid credentials' do
      it 'logs in the user and returns a success response' do
        post :create, params: { user: valid_credentials }
        expect(response).to have_http_status(:ok)
        expect(json_response[:status][:code]).to eq(200)
        expect(json_response[:status][:message]).to eq('Logged in successfully.')
        expect(json_response[:data][:user][:email]).to eq(user.email)
      end
    end

    context 'with invalid credentials' do
      it 'returns an unauthorized response' do
        post :create, params: { user: invalid_credentials }
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to include('Invalid Email or password.')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with a valid token' do
      before do
        sign_in user
        @token = request.env['warden-jwt_auth.token']
      end

      it 'logs out the user and returns a success response' do
        request.headers['Authorization'] = "Bearer #{valid_token}"
        delete :destroy
        expect(response).to have_http_status(:ok)
        expect(json_response[:status]).to eq(200)
        expect(json_response[:message]).to eq('Logged out successfully.')
      end
    end

    context 'with an invalid token' do
      it 'returns an unauthorized response' do
        request.headers['Authorization'] = 'Bearer invalid_token'
        delete :destroy
        expect(response).to have_http_status(:unauthorized)
        expect(json_response[:status]).to eq(401)
        expect(json_response[:message]).to match(/Invalid token/)
      end
    end

    context 'without a token' do
      it 'returns an unauthorized response' do
        delete :destroy
        expect(response).to have_http_status(:unauthorized)
        expect(json_response[:status]).to eq(401)
        expect(json_response[:message]).to eq('Authorization header is missing.')
      end
    end
  end

  private

  def json_response
    JSON.parse(response.body, symbolize_names: true)
  end
end