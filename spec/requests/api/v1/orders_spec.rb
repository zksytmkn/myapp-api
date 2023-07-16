require 'rails_helper'

RSpec.describe 'Api::V1::Orders', type: :request do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:order) { create(:order, user: user) }
  let(:order_detail) { create(:order_detail, order: order, product: product) }
  let(:cart) { create(:cart, user: user, product: product) }
  let(:headers) { { 'X-Requested-With': 'XMLHttpRequest' } }

  before do
    allow_any_instance_of(Api::V1::OrdersController).to receive(:current_user).and_return(user)
  end

  describe 'GET /index' do
    before do
      get '/api/v1/orders', headers: headers
    end

    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    before do
      get "/api/v1/orders/#{order_detail.id}", headers: headers
    end

    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    let(:valid_attributes) { { order: { billing_amount: 1000 } } }
  
    context 'with valid attributes' do
      before do
        # Create a cart for the current user
        create(:cart, user: user, product: product)
        post '/api/v1/orders', params: valid_attributes, headers: headers
      end
  
      it 'creates a new order' do
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['billing_amount']).to eq(1000)
      end
    end
  
    context 'with invalid attributes' do
      before do
        post '/api/v1/orders', params: { order: { billing_amount: nil } }, headers: headers
      end
  
      it 'does not create a new order' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
