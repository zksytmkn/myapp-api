require 'rails_helper'

RSpec.describe 'Api::V1::PostFavorites', type: :request do
  let(:user) { create(:user) }
  let!(:post_object) { create(:post, user: user) }
  let!(:post_favorite) { create(:post_favorite, user: user, post: post_object) }
  let(:headers) { { 'X-Requested-With': 'XMLHttpRequest' } }

  before do
    allow_any_instance_of(Api::V1::PostFavoritesController).to receive(:current_user).and_return(user)
  end

  describe 'GET /index' do
    before do
      get "/api/v1/post_favorites", headers: headers
    end

    it 'returns the list of favorites' do
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).length).to eq(1)
    end
  end

  describe 'POST /create' do
    let!(:post_favorite) { nil }
    let(:valid_attributes) { { post_id: post_object.id } }
    let(:invalid_attributes) { { post_id: nil } }

    context 'with valid parameters' do
      before do
        post "/api/v1/post_favorites", params: { post_favorite: valid_attributes }, headers: headers
      end

      it 'creates a new favorite' do
        expect(response).to have_http_status(:created)
        expect(PostFavorite.count).to eq(1)
      end
    end

    context 'with invalid parameters' do
      before do
        post "/api/v1/post_favorites", params: { post_favorite: invalid_attributes }, headers: headers
      end

      it 'does not create a new favorite' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(PostFavorite.count).to eq(0)
      end
    end
  end

  describe 'DELETE /destroy' do
    before do
      post_unfavorite = create(:post_unfavorite, user: user, post: post_object)
      delete "/api/v1/post_favorites/#{post_object.id}/user", headers: headers
    end

    it 'deletes the favorite' do
      expect(response).to have_http_status(:no_content)
      expect(PostFavorite.count).to eq(0)
    end
  end
end
