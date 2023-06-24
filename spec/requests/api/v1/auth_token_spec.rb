require 'rails_helper'

RSpec.describe Api::V1::AuthTokenController, type: :request do
  let(:user) { create(:user) }
  let(:valid_params) { { auth: { email: user.email, password: user.password } } }
  let(:invalid_params) { { auth: { email: user.email, password: 'wrong password' } } }

  describe "POST /create" do
    context "with valid params" do
      before { post '/api/v1/auth_token', params: valid_params }

      it 'returns a 200 status code' do
        expect(response).to have_http_status(200)
      end

      it 'returns the user token' do
        expect(JSON.parse(response.body)).to include("token")
      end
    end

    context "with invalid params" do
      before { post '/api/v1/auth_token', params: invalid_params }

      it 'returns a 404 status code' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "POST /refresh" do
    context "with valid session" do
      before do
        # ログインするためのAPIを呼び出し、その結果からrefresh_tokenを取得
        # refresh_tokenをCookieにセットする
        post '/api/v1/auth_token', params: valid_params
        cookies[session_key] = response.cookies[session_key]
        post '/api/v1/auth_token/refresh'
      end
  
      it 'returns a 200 status code' do
        expect(response).to have_http_status(200)
      end
  
      it 'returns the user token' do
        expect(JSON.parse(response.body)).to include("token")
      end
    end
  
    context "with invalid session" do
      before { post '/api/v1/auth_token/refresh' }
  
      it 'returns a 401 status code' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "DELETE /destroy" do
    context "with valid session" do
      before do
        # ログインするためのAPIを呼び出し、その結果からrefresh_tokenを取得
        # refresh_tokenをCookieにセットする
        post '/api/v1/auth_token', params: valid_params
        cookies[session_key] = response.cookies[session_key]
        delete '/api/v1/auth_token'
      end
  
      it 'returns a 200 status code' do
        expect(response).to have_http_status(200)
      end
  
      it 'deletes the user session' do
        expect(cookies[session_key]).to be_nil
      end
    end
  
    context "with invalid session" do
      before { delete '/api/v1/auth_token' }
  
      it 'returns a 401 status code' do
        expect(response).to have_http_status(401)
      end
    end
  end
end
