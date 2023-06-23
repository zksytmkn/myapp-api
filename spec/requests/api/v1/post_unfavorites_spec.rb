require 'rails_helper'

RSpec.describe 'Api::V1::PostUnfavorites', type: :request do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let!(:post_unfavorite) { create(:post_unfavorite, user: user, post: post) }

  before do
    allow_any_instance_of(Api::V1::PostUnfavoritesController).to receive(:current_user).and_return(user)
  end

  describe 'GET /index' do
    before do
      get "/api/v1/post_unfavorites"
    end

    it 'returns the list of unfavorites' do
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).length).to eq(1)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      before do
        post "/api/v1/post_unfavorites", params: { post_unfavorite: { post_id: post.id } }
      end

      it 'creates a new unfavorite' do
        expect(response).to have_http_status(:created)
        expect(PostUnfavorite.count).to eq(2)
      end
    end

    context 'with invalid parameters' do
      before do
        post "/api/v1/post_unfavorites", params: { post_unfavorite: { post_id: nil } }
      end

      it 'does not create a new unfavorite' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(PostUnfavorite.count).to eq(1)
      end
    end
  end

  describe 'DELETE /destroy' do
    before do
      delete "/api/v1/post_unfavorites/#{post_unfavorite.id}"
    end

    it 'deletes the unfavorite' do
      expect(response).to have_http_status(:no_content)
      expect(PostUnfavorite.count).to eq(0)
    end
  end
end
