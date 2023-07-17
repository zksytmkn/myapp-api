require 'rails_helper'

RSpec.describe "Api::V1::Carts", type: :request do
  let(:user) { create(:user) }
  let(:product) { create(:product, stock: 10) }
  let(:cart) { create(:cart, user: user, product: product) }  # cartの定義を追加
  let(:headers) { { 'X-Requested-With': 'XMLHttpRequest' } }

  describe "GET /index" do
    let(:user2) { create(:user) }
    let!(:cart1) { create(:cart, user: user, product: product) }
    let!(:cart2) { create(:cart, user: user2, product: product) }

    before do
      allow_any_instance_of(Api::V1::CartsController).to receive(:current_user).and_return(user)
      get '/api/v1/carts', headers: headers
    end

    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'returns all carts of current user' do
      returned_carts = JSON.parse(response.body)
      expect(returned_carts.size).to eq(1)
      expect(returned_carts.first['id']).to eq(cart1.id)
    end
  end

  describe "POST /create" do
    let(:valid_attributes) { { cart: { product_id: product.id, quantity: 5 } } }

    before do
      allow_any_instance_of(Api::V1::CartsController).to receive(:current_user).and_return(user)
    end
  
    context "with valid attributes" do
      it 'creates a new cart' do
        expect do
          post '/api/v1/carts', params: valid_attributes, headers: headers
        end.to change(Cart, :count).by(1)
  
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['product_id']).to eq(product.id)
        expect(JSON.parse(response.body)['quantity']).to eq(5)
      end
  
      it 'does not create a new cart if it already exists for the same user and product' do
        create(:cart, user: user, product: product)
  
        expect do
          post '/api/v1/carts', params: valid_attributes, headers: headers
        end.to change(Cart, :count).by(0)
  
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to include('ユーザーはすでに存在します')
      end
    end
  end

  describe "PUT /update" do
    let(:valid_attributes) { { cart: { quantity: 3 } } }

    context "with valid attributes" do
      before do
        allow_any_instance_of(Api::V1::CartsController).to receive(:current_user).and_return(user)
        put "/api/v1/carts/#{cart.id}", params: valid_attributes, headers: headers
      end

      it 'updates the cart' do
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['quantity']).to eq(3)
      end
    end

    context "with invalid attributes" do
      before do
        allow_any_instance_of(Api::V1::CartsController).to receive(:current_user).and_return(user)
        put "/api/v1/carts/#{cart.id}", params: { cart: { quantity: 15 } }, headers: headers
      end

      it 'does not update the cart due to insufficient stock' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('在庫が不足しています')
      end
    end
  end

  describe "DELETE /destroy" do
    before do
      allow_any_instance_of(Api::V1::CartsController).to receive(:current_user).and_return(user)
      delete "/api/v1/carts/#{cart.id}", headers: headers
    end

    it 'deletes the cart' do
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to eq('カートから削除しました')
    end
  end
end
