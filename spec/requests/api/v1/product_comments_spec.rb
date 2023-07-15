require 'rails_helper'

RSpec.describe "Api::V1::ProductComments", type: :request do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let!(:product_comment) { create(:product_comment, user: user, product: product) }
  let(:headers) { { 'X-Requested-With': 'XMLHttpRequest' } }

  before do
    allow_any_instance_of(Api::V1::ProductCommentsController).to receive(:current_user).and_return(user)
  end

  describe "GET /index" do
    before do
      get "/api/v1/products/#{product.id}/product_comments", headers: headers
    end

    it "returns a list of product_comments" do
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).length).to eq(1)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      before do
        post "/api/v1/products/#{product.id}/product_comments", params: { product_comment: { content: "This is a comment" } }, headers: headers
      end

      it "creates a new product comment" do
        expect(response).to have_http_status(:created)
        expect(ProductComment.count).to eq(2)
      end
    end

    context "with invalid parameters" do
      before do
        post "/api/v1/products/#{product.id}/product_comments", params: { product_comment: { content: "" } }, headers: headers
      end

      it "does not create a new product comment" do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(ProductComment.count).to eq(1)
      end
    end
  end

  describe "DELETE /destroy" do
    before do
      delete "/api/v1/products/#{product.id}/product_comments/#{product_comment.id}", headers: headers
    end

    it "deletes the product comment" do
      expect(response).to have_http_status(:no_content)
      expect(ProductComment.count).to eq(0)
    end
  end
end
