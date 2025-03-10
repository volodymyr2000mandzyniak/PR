# # spec/requests/rack_attack_spec.rb

# require 'rails_helper'

# RSpec.describe 'Rack::Attack', type: :request do
#   include Rack::Test::Methods

#   before do
#     Rack::Attack.cache.store.clear
#   end

#   describe 'throttle excessive requests' do
#     context 'when the request limit is exceeded' do
#       it 'returns a 429 status code' do
#         101.times { get '/projects' }
#         expect(last_response.status).to eq(429)
#         expect(last_response.body).to include('Rate limit exceeded')
#       end
#     end

#     context 'when the request limit is not exceeded' do
#       it 'allows requests' do
#         50.times { get '/projects' }
#         expect(last_response.status).to eq(200)
#       end
#     end
#   end
# end