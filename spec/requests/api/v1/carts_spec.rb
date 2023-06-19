RSpec.describe "Api::V1::Carts", type: :request do
  let(:user) { create(:user) }
  let(:product) { create(:product, stock: 10) }
  let(:cart) { create(:cart, user: user, product: product) }

  before do
    allow_any_instance_of(Api::V1::CartsController).to receive(:current_user).and_return(user)
  end

  describe "GET /index" do
    let!(:cart1) { create(:cart, user: user, product: product) }
    let!(:cart2) { create(:cart, user: user, product: product) }
  
    before do
      get '/api/v1/carts'
    end
  
    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end
  
    it 'returns all carts' do
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "POST /create" do
    let(:valid_attributes) { { cart: { product_id: product.id, quantity: 5 } } }

    context "with valid attributes" do
      before do
        post '/api/v1/carts', params: valid_attributes
      end

      it 'creates a new cart' do
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['product_id']).to eq(product.id)
        expect(JSON.parse(response.body)['quantity']).to eq(5)
      end

      it 'does not create a new cart if it already exists for the same user and product' do
        create(:cart, user: user, product: product)
        post '/api/v1/carts', params: valid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to include('has already been taken')
      end
    end

    context "with invalid attributes" do
      before do
        post '/api/v1/carts', params: { cart: { product_id: product.id, quantity: 15 } }
      end

      it 'does not create a new cart due to insufficient stock' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('在庫が不足しています')
      end
    end

    context "with existing cart for the same user and product" do
      before do
        create(:cart, user: user, product: product)
        post '/api/v1/carts', params: valid_attributes
      end

      it 'does not create a new cart' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to include('has already been taken')
      end
    end
  end

  describe "PUT /update" do
    let(:valid_attributes) { { cart: { quantity: 3 } } }

    context "with valid attributes" do
      before do
        put "/api/v1/carts/#{cart.id}", params: valid_attributes
      end

      it 'updates the cart' do
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['quantity']).to eq(3)
      end
    end

    context "with invalid attributes" do
      before do
        put "/api/v1/carts/#{cart.id}", params: { cart: { quantity: 15 } }
      end

      it 'does not update the cart due to insufficient stock' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('在庫が不足しています')
      end
    end
  end

  describe "DELETE /destroy" do
    before do
      delete "/api/v1/carts/#{cart.id}"
    end

    it 'deletes the cart' do
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to eq('カートから削除しました')
    end
  end
end
