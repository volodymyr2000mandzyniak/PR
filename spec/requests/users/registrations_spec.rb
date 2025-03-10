# spec/requests/users/registrations_spec.rb
require 'rails_helper'

RSpec.describe 'Users::Registrations', type: :request do
  let(:valid_attributes) do
    {
      user: attributes_for(:user)
    }
  end

  let(:invalid_attributes) do
    {
      user: attributes_for(:user, password_confirmation: 'wrongpassword')
    }
  end

  describe 'POST /users/sign_up' do
    context 'with valid parameters' do
      it 'creates a new user' do
        expect {
          post user_registration_path, params: valid_attributes
        }.to change(User, :count).by(1)
      end

      it 'returns a success response' do
        post user_registration_path, params: valid_attributes
        expect(response).to have_http_status(:ok)
        expect(json_response['status']['message']).to eq('Signed up successfully.')
        expect(json_response['data']['user']['email']).to eq(valid_attributes[:user][:email])
        expect(json_response['data']['user']).to include('id', 'email', 'created_at')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new user' do
        expect {
          post user_registration_path, params: invalid_attributes
        }.not_to change(User, :count)
      end

      it 'returns an error response' do
        post user_registration_path, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response['status']['message']).to include("Password confirmation doesn't match Password")
      end
    end

    context 'with duplicate email' do
      before { create(:user, email: 'test@example.com') }

      let(:duplicate_attributes) do
        {
          user: attributes_for(:user, email: 'test@example.com')
        }
      end

      it 'does not create a new user' do
        expect {
          post user_registration_path, params: duplicate_attributes
        }.not_to change(User, :count)
      end

      it 'returns an error response' do
        post user_registration_path, params: duplicate_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response['status']['message']).to include('Email has already been taken')
      end
    end

    context 'with invalid email format' do
      let(:invalid_email_attributes) do
        {
          user: attributes_for(:user, email: 'invalid-email')
        }
      end

      it 'does not create a new user' do
        expect {
          post user_registration_path, params: invalid_email_attributes
        }.not_to change(User, :count)
      end

      it 'returns an error response' do
        post user_registration_path, params: invalid_email_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response['status']['message']).to include('Email is invalid')
      end
    end

    context 'with empty email' do
      let(:empty_email_attributes) do
        {
          user: attributes_for(:user, email: '')
        }
      end

      it 'does not create a new user' do
        expect {
          post user_registration_path, params: empty_email_attributes
        }.not_to change(User, :count)
      end

      it 'returns an error response' do
        post user_registration_path, params: empty_email_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response['status']['message']).to include("Email can't be blank")
      end
    end

    context 'with short password' do
      let(:short_password_attributes) do
        {
          user: attributes_for(:user, password: 'short', password_confirmation: 'short')
        }
      end

      it 'does not create a new user' do
        expect {
          post user_registration_path, params: short_password_attributes
        }.not_to change(User, :count)
      end

      it 'returns an error response' do
        post user_registration_path, params: short_password_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response['status']['message']).to include('Password is too short')
      end
    end

    context 'with empty password' do
      let(:empty_password_attributes) do
        {
          user: attributes_for(:user, password: '', password_confirmation: '')
        }
      end

      it 'does not create a new user' do
        expect {
          post user_registration_path, params: empty_password_attributes
        }.not_to change(User, :count)
      end

      it 'returns an error response' do
        post user_registration_path, params: empty_password_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response['status']['message']).to include("Password can't be blank")
      end
    end
  end

  private

  def json_response
    JSON.parse(response.body)
  end
end