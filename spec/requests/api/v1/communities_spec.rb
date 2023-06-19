require 'rails_helper'

RSpec.describe "Api::V1::Communities", type: :request do
  let!(:user) { create(:user) }
  let!(:community1) { create(:community, user: user) }
  let!(:community2) { create(:community, user: user) }

  before do
    allow_any_instance_of(Api::V1::CommunitiesController).to receive(:current_user).and_return(user)
  end

  describe "GET /index" do
    before do
      get '/api/v1/communities'
    end

    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'returns all communities' do
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "GET /show" do
    before do
      get "/api/v1/communities/#{community1.id}"
    end

    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the community' do
      json = JSON.parse(response.body)
      expect(json['community']['id']).to eq(community1.id)
      expect(json.keys).to contain_exactly('community', 'participation', 'invited', 'inviting')
    end
  end

  describe "POST /create" do
    let(:valid_params) { { name: 'New Community', description: 'New community description', image: 'new_image.jpg' } }

    context 'when valid params are sent' do
      before do
        post '/api/v1/communities', params: valid_params
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(:created)
      end

      it 'creates a new community' do
        expect(Community.count).to eq(3)
      end
    end

    context 'when invalid params are sent' do
      let(:invalid_params) { { name: '', description: 'New community description', image: 'new_image.jpg' } }

      before do
        post '/api/v1/communities', params: invalid_params
      end

      it 'returns an error response' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not create a new community' do
        expect(Community.count).to eq(2)
      end
    end
  end

  describe "PATCH /update" do
    let(:valid_params) { { name: 'Updated Community' } }

    before do
      patch "/api/v1/communities/#{community1.id}", params: valid_params
    end

    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'updates the community' do
      expect(community1.reload.name).to eq('Updated Community')
    end
  end

  describe "DELETE /destroy" do
    before do
      delete "/api/v1/communities/#{community1.id}"
    end

    it 'returns a successful response' do
      expect(response).to have_http_status(:ok)
    end

    it 'deletes the community' do
      expect(Community.count).to eq(1)
    end
  end
end
