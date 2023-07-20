require 'rails_helper'

RSpec.describe Api::V1::AuthTokenController, type: :request do
  let(:user) { create(:user) }
  let(:valid_params) { { auth: { email: user.email, password: user.password } } }
  let(:invalid_params) { { auth: { email: user.email, password: 'wrong password' } } }
  let(:session_key) { Rails.application.config.session_options[:key] }
  let(:headers) { { 'X-Requested-With': 'XMLHttpRequest' } }

  describe "POST /create" do
    context "with valid params" do
      before { post '/api/v1/auth_token', params: valid_params, headers: headers }
  
      it 'returns a 200 status code' do
        expect(response).to have_http_status(200)
      end
    end

    context "with invalid params" do
      before { post '/api/v1/auth_token', params: invalid_params, headers: headers }

      it 'returns a 404 status code' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "POST /refresh" do
    context "with valid session" do
      before do
        post '/api/v1/auth_token', params: valid_params, headers: headers
        cookies[session_key] = response.cookies[session_key]
        post '/api/v1/auth_token/refresh', headers: headers
      end
  
      it 'returns a 200 status code' do
        expect(response).to have_http_status(200)
      end
    end
  
    context "with invalid session" do
      before { post '/api/v1/auth_token/refresh', headers: headers }
  
      it 'returns a 401 status code' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "DELETE /destroy" do
    context "with valid session" do
      before do
        post '/api/v1/auth_token', params: valid_params, headers: headers
        cookies[session_key] = response.cookies[session_key]
        delete '/api/v1/auth_token', headers: headers
      end
  
      it 'returns a 200 status code' do
        expect(response).to have_http_status(200)
      end
  
      it 'deletes the user session' do
        expect(cookies[session_key]).to eq("")
      end
    end
  
    context "with invalid session" do
      before { delete '/api/v1/auth_token', headers: headers }
  
      it 'returns a 401 status code' do
        expect(response).to have_http_status(401)
      end
    end
  end
end
