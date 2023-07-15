require 'rails_helper'

RSpec.describe "Api::V1::ProductFavorites", type: :request do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:headers) { { 'X-Requested-With': 'XMLHttpRequest' } }

  before do
    allow_any_instance_of(Api::V1::ProductFavoritesController).to receive(:current_user).and_return(user)
  end

  describe "GET /index" do
    before do
      create(:product_favorite, user: user, product: product)
      get "/api/v1/product_favorites", headers: headers
    end

    it "returns a list of favorite products" do
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).length).to eq(1)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      before do
        post "/api/v1/product_favorites", params: { product_favorite: { product_id: product.id } }, headers: headers
      end

      it "creates a new favorite product" do
        expect(response).to have_http_status(:created)
        expect(ProductFavorite.count).to eq(1)
      end
    end

    context "with invalid parameters" do
      before do
        post "/api/v1/product_favorites", params: { product_favorite: { product_id: nil } }, headers: headers
      end

      it "does not create a new favorite product" do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(ProductFavorite.count).to eq(0)
      end
    end
  end

  describe "DELETE /destroy" do
    before do
      product_favorite = create(:product_favorite, user: user, product: product)
      delete "/api/v1/product_favorites/#{product.id}/user", headers: headers
    end

    it "deletes the product_favorite" do
      expect(response).to have_http_status(:no_content)
      expect(ProductFavorite.count).to eq(0)
    end
  end
end
