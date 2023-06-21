require 'rails_helper'

RSpec.describe "Api::V1::Invitations", type: :request do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:community) { create(:community) }

  before do
    allow_any_instance_of(Api::V1::InvitationsController).to receive(:current_user).and_return(user1)
  end

  describe 'GET #index' do
    let!(:invitation1) { create(:invitation, inviting: user1, invited: user2, community: community) }

    before do
      get '/api/v1/invitations'
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'returns the communities the user is invited to' do
      expect(response.body).to include(community.name)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) { { invitation: { invited_id: user2.id, community_id: community.id } } }

      it 'returns a successful response' do
        post '/api/v1/invitations', params: valid_params
        expect(response).to have_http_status(:created)
      end

      it 'creates a new invitation' do
        expect {
          post '/api/v1/invitations', params: valid_params
        }.to change(Invitation, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { invitation: { invited_id: nil, community_id: nil } } }

      it 'does not create a new invitation' do
        expect {
          post '/api/v1/invitations', params: invalid_params
        }.to change(Invitation, :count).by(0)
      end

      it 'returns an error' do
        post '/api/v1/invitations', params: invalid_params
        expect(response.body).to include('error')
      end
    end
  end
end
