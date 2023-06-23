require 'rails_helper'

RSpec.describe "Api::V1::Products", type: :request do
  let(:user) { create(:user) }
  let!(:product) { create(:product, user: user) }

  before do
    allow_any_instance_of(Api::V1::ProductsController).to receive(:current_user).and_return(user)
  end

  describe "GET /index" do
    before do
      get "/api/v1/products"
    end

    it "returns a list of all products" do
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).length).to eq(1)
    end
  end

  describe "GET /show" do
    before do
      get "/api/v1/products/#{product.id}"
    end

    it "returns the product" do
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['product']['id']).to eq(product.id)
    end
  end

  describe "POST /create" do
    let(:valid_attributes) { { name: "Test product", category: "Test category", price: 100, description: "Test description", stock: 10 } }
    let(:invalid_attributes) { { name: nil, category: nil, price: nil, description: nil, stock: nil } }

    context "with valid parameters" do
      before do
        post "/api/v1/products", params: valid_attributes
      end

      it "creates a new product" do
        expect(response).to have_http_status(:created)
        expect(Product.count).to eq(2)
      end
    end

    context "with invalid parameters" do
      before do
        post "/api/v1/products", params: invalid_attributes
      end

      it "does not create a new product" do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(Product.count).to eq(1)
      end
    end
  end

  describe "PUT /update" do
    let(:valid_attributes) { { name: "Updated product" } }
    let(:invalid_attributes) { { name: nil } }

    context "with valid parameters" do
      before do
        put "/api/v1/products/#{product.id}", params: valid_attributes
      end

      it "updates the product" do
        expect(response).to have_http_status(:success)
        expect(product.reload.name).to eq("Updated product")
      end
    end

    context "with invalid parameters" do
      before do
        put "/api/v1/products/#{product.id}", params: invalid_attributes
      end

      it "does not update the product" do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(product.reload.name).to_not eq(nil)
      end
    end
  end

  describe "DELETE /destroy" do
    before do
      delete "/api/v1/products/#{product.id}"
    end

    it "deletes the product" do
      expect(response).to have_http_status(:no_content)
      expect(Product.count).to eq(0)
    end
  end
end
