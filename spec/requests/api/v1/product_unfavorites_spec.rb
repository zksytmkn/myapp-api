require 'rails_helper'

RSpec.describe "Api::V1::ProductUnfavorites", type: :request do
  let(:user) { create(:user) }
  let!(:product) { create(:product, user: user) }
  let!(:product_unfavorite) { create(:product_unfavorite, user: user, product: product) }
  let(:headers) { { 'X-Requested-With': 'XMLHttpRequest' } }

  before do
    allow_any_instance_of(Api::V1::ProductUnfavoritesController).to receive(:current_user).and_return(user)
  end

  describe "GET /index" do
    before do
      get "/api/v1/product_unfavorites", headers: headers
    end

    it "returns a list of all product_unfavorites" do
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).length).to eq(1)
    end
  end

  describe "POST /create" do
    let!(:product_unfavorite) { nil }
    let(:valid_attributes) { { product_id: product.id } }
    let(:invalid_attributes) { { product_id: nil } }

    context "with valid parameters" do
      before do
        post "/api/v1/product_unfavorites", params: { product_unfavorite: valid_attributes }, headers: headers
      end

      it "creates a new product_unfavorite" do
        expect(response).to have_http_status(:created)
        expect(ProductUnfavorite.count).to eq(1)
      end
    end

    context "with invalid parameters" do
      before do
        post "/api/v1/product_unfavorites", params: { product_unfavorite: invalid_attributes }, headers: headers
      end

      it "does not create a new product_unfavorite" do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(ProductUnfavorite.count).to eq(0)
      end
    end
  end

  describe "DELETE /destroy" do
    before do
      delete "/api/v1/product_unfavorites/#{product.id}/user", headers: headers
    end
  
    it "deletes the product_unfavorite" do
      expect(response).to have_http_status(:no_content)
      expect(ProductUnfavorite.count).to eq(0)
    end
  end
end