require 'rails_helper'

RSpec.describe 'Api::V1::Participations', type: :request do
  let(:user) { create(:user) }
  let(:community) { create(:community) }
  let(:headers) { { 'X-Requested-With': 'XMLHttpRequest' } }

  before do
    allow_any_instance_of(Api::V1::ParticipationsController).to receive(:current_user).and_return(user)
  end

  describe 'GET /index' do
    before do
      create(:participation, user: user, community: community)
      get '/api/v1/participations', headers: headers
    end

    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    let(:valid_attributes) { { participation: { community_id: community.id } } }

    context 'with valid attributes' do
      before do
        post '/api/v1/participations', params: valid_attributes, headers: headers
      end

      it 'creates a new participation' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid attributes' do
      before do
        post '/api/v1/participations', params: { participation: { community_id: nil } }, headers: headers
      end

      it 'does not create a new participation' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:participation) { create(:participation, user: user, community: community) }

    before do
      delete "/api/v1/participations/#{participation.community_id}", headers: headers
    end

    it 'deletes the participation' do
      expect(response).to have_http_status(:no_content)
    end
  end
end
