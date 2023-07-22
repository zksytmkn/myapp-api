require 'rails_helper'

RSpec.describe Api::V1::AuthTokenController, type: :request do
  let(:user) { create(:user) }
  let(:valid_params) { { auth: { email: user.email, password: user.password } } }
  let(:invalid_params) { { auth: { email: user.email, password: 'wrong password' } } }
  let(:session_key) { Rails.application.config.session_options[:key] }
  let(:headers) { { 'X-Requested-With': 'XMLHttpRequest' } }

  describe "POST /create" do
    context "with invalid params" do
      before { post '/api/v1/auth_token', params: invalid_params, headers: headers }

      it 'returns a 404 status code' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "POST /refresh" do  
    context "with invalid session" do
      before { post '/api/v1/auth_token/refresh', headers: headers }
  
      it 'returns a 401 status code' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "DELETE /destroy" do  
    context "with invalid session" do
      before { delete '/api/v1/auth_token', headers: headers }
  
      it 'returns a 401 status code' do
        expect(response).to have_http_status(401)
      end
    end
  end
end
