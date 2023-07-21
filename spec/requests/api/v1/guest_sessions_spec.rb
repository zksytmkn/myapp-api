require 'rails_helper'

RSpec.describe "Api::V1::GuestSessions", type: :request do
  let(:headers) { { 'X-Requested-With': 'XMLHttpRequest' } }

  describe "POST /create" do
    context "when a guest user is successfully created" do
      it "returns the auth credentials of the guest user" do
        begin
          expect {
            post "/api/v1/guest_sessions", headers: headers
          }.to change(User, :count).by(1)
        rescue => e  # Catch all exceptions
          Rails.logger.error "Failed to create guest user in test: #{e.message}"
          Rails.logger.error e.backtrace.join("\n")
          raise e
        end
      
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json['auth']['email']).to match(/@example.com/)
        expect(json['auth']['password']).to be_present
      end
    end
  end

  describe "DELETE /destroy" do
    let(:user) { create(:user, is_guest: true) }
    before do
      allow_any_instance_of(Api::V1::GuestSessionsController).to receive(:session_user).and_return(user)
    end

    context "when the session is successfully deleted" do
      before do
        allow(user).to receive(:forget).and_return(true)
        allow_any_instance_of(Api::V1::GuestSessionsController).to receive(:delete_session).and_return(true)
        allow_any_instance_of(Api::V1::GuestSessionsController).to receive(:session_key).and_return('test_session_key')
        allow_any_instance_of(Api::V1::GuestSessionsController).to receive(:cookies).and_return({ 'test_session_key' => nil })
      end

      it "returns a successful response" do
        delete "/api/v1/guest_sessions/#{user.id}", headers: headers
        expect(response).to have_http_status(:ok)
      end
    end

    context "when the session deletion fails" do
      before do
        allow(user).to receive(:forget).and_return(true)
        allow_any_instance_of(Api::V1::GuestSessionsController).to receive(:delete_session).and_return(true)
        allow_any_instance_of(Api::V1::GuestSessionsController).to receive(:session_key).and_return('test_session_key')
        allow_any_instance_of(Api::V1::GuestSessionsController).to receive(:cookies).and_return({ 'test_session_key' => 'exists' })
      end

      it "returns an error response" do
        delete "/api/v1/guest_sessions/#{user.id}", headers: headers
        expect(response).to have_http_status(:internal_server_error)
      end
    end
  end
end

