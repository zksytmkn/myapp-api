require 'rails_helper'

RSpec.describe 'Api::V1::PasswordResets', type: :request do
  let(:user) { create(:user) }
  let(:headers) { { 'X-Requested-With': 'XMLHttpRequest' } }

  describe 'PUT /update' do
    context 'with valid reset password token and password' do
      before do
        user.update!(reset_password_token: 'valid_token', reset_password_expires_at: 1.hour.from_now)
        put '/api/v1/password_resets', params: { token: 'valid_token', password: 'P@ssw0rd' }, headers: headers
      end

      it 'updates the password' do
        expect(response).to have_http_status(:ok)
        user.reload
        expect(user.authenticate('P@ssw0rd')).to be_truthy
      end
    end

    context 'with invalid reset password token' do
      before do
        put '/api/v1/users/reset_password', params: { token: 'invalid_token', password: 'new_password' }, headers: headers
      end

      it 'does not update the password' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with expired reset password token' do
      before do
        user.update!(reset_password_token: 'expired_token', reset_password_expires_at: 1.hour.ago)
        put '/api/v1/password_resets', params: { token: 'expired_token', password: 'new_password' }, headers: headers
      end

      it 'does not update the password' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with invalid password' do
      before do
        user.update!(reset_password_token: 'valid_token', reset_password_expires_at: 1.hour.from_now)
        put '/api/v1/password_resets', params: { token: 'valid_token', password: 'invalid_password' }, headers: headers
      end

      it 'does not update the password' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET /reset_password_confirmation' do
    context 'with valid reset password token' do
      before do
        user.update!(reset_password_token: 'valid_token', reset_password_expires_at: 1.hour.from_now)
        get '/api/v1/password_resets/reset_password_confirmation', params: { token: 'valid_token' }, headers: headers
      end

      it 'returns success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid reset password token' do
      before do
        get '/api/v1/password_resets/reset_password_confirmation', params: { token: 'invalid_token' }, headers: headers
      end

      it 'returns error' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with expired reset password token' do
      before do
        user.update!(reset_password_token: 'expired_token', reset_password_expires_at: 1.hour.ago)
        get '/api/v1/password_resets/reset_password_confirmation', params: { token: 'expired_token' }, headers: headers
      end
    
      it 'returns a new reset password token' do
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['reset_password_token']).not_to be_nil
      end
    end
  end
end
