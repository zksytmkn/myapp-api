RSpec.describe UserAuthenticateService, type: :service do
  let(:user) { create(:user) }
  let(:headers) { { "Authorization" => "Bearer #{token}" } }
  let(:request) { instance_double("ActionController::TestRequest", headers: headers) }
  let(:cookies) { instance_double("ActionController::TestRequest::CookieJar") }
  let(:service) { TestService.new(request, cookies) }

  class TestService
    include UserAuthenticateService

    def initialize(request, cookies)
      @request = request
      @cookies = cookies
    end

    def request
      @request
    end

    def cookies
      @cookies
    end

    def unauthorized_user
      raise "Unauthorized"
    end
  end

  before do
    allow(cookies).to receive(:delete)
  end

  describe '#authenticate_user' do
    context 'when token is valid' do
      let(:token) { "valid_token" }

      before do
        allow(service).to receive(:current_user).and_return(user)
      end

      it 'returns true' do
        expect(service.authenticate_user).to eq(true)
      end
    end

    context 'when token is invalid' do
      let(:token) { 'invalid_token' }

      before do
        allow(service).to receive(:current_user).and_return(nil)
      end

      it 'returns unauthorized status' do
        expect { service.authenticate_user }.to raise_error('Unauthorized')
      end
    end
  end

  describe '#authenticate_active_user' do
    context 'when token is valid and user is confirmed' do
      let(:token) { "valid_token" }

      before do
        allow(service).to receive(:current_user).and_return(user)
        allow(user).to receive(:confirmation_status?).and_return(true)
      end

      it 'returns true' do
        expect(service.authenticate_active_user).to eq(true)
      end
    end

    context 'when token is valid but user is not confirmed' do
      let(:token) { "valid_token" }

      before do
        allow(service).to receive(:current_user).and_return(user)
        allow(user).to receive(:confirmation_status?).and_return(false)
      end

      it 'returns unauthorized status' do
        expect { service.authenticate_active_user }.to raise_error('Unauthorized')
      end
    end

    context 'when token is invalid' do
      let(:token) { 'invalid_token' }

      before do
        allow(service).to receive(:current_user).and_return(nil)
      end

      it 'returns unauthorized status' do
        expect { service.authenticate_active_user }.to raise_error('Unauthorized')
      end
    end
  end
end
