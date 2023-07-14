require 'rails_helper'

RSpec.describe "Api::V1::Products", type: :request do
  let(:user) { create(:user) }
  let!(:product) { create(:product, user: user) }
  let(:headers) { { 'X-Requested-With': 'XMLHttpRequest' } }

  before do
    allow_any_instance_of(Api::V1::ProductsController).to receive(:current_user).and_return(user)
  end

  describe "GET /index" do
    before do
      get "/api/v1/products", headers: headers
    end

    it "returns a list of all products" do
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).length).to eq(1)
    end
  end

  describe "GET /show" do
    before do
      get "/api/v1/products/#{product.id}", headers: headers
    end

    it "returns the product" do
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['product']['id']).to eq(product.id)
    end
  end

  describe "POST /create" do
    let(:valid_attributes) { { name: "農産物", category: "野菜", price: 100, description: "説明文", stock: 10 } }
    let(:invalid_attributes) { { name: '' } }
  
    context "with valid parameters" do
      before do
        post "/api/v1/products", params: valid_attributes, headers: headers
      end

      it "creates a new product" do
        expect(response).to have_http_status(:created)
        expect(Product.count).to eq(2)
      rescue
        puts response.body
      end
    end

    context "with invalid parameters" do
      before do
        post "/api/v1/products", params: invalid_attributes, headers: headers
      end

      it "does not create a new product" do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(Product.count).to eq(1)
      end
    end
  end

  describe "PUT /update" do
    let(:valid_attributes) { { name: "農産物更新後" } }
    let(:invalid_attributes) { { name: "" } }

    context "with valid parameters" do
      before do
        put "/api/v1/products/#{product.id}", params: valid_attributes, headers: headers
      end
    
      it "updates the product" do
        product.reload
        expect(response).to have_http_status(:success)
        expect(product.name).to eq("農産物更新後")
      rescue
        puts response.body
      end
    end

    context "with invalid parameters" do
      before do
        put "/api/v1/products/#{product.id}", params: invalid_attributes, headers: headers
      end

      it "does not update the product" do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(product.reload.name).to_not eq(nil)
      end
    end
  end

  describe "DELETE /destroy" do
    before do
      delete "/api/v1/products/#{product.id}", headers: headers
    end

    it "deletes the product" do
      expect(response).to have_http_status(:no_content)
      expect(Product.count).to eq(0)
    end
  end
end
