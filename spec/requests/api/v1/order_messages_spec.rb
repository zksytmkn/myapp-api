require 'rails_helper'

RSpec.describe "Api::V1::OrderMessages", type: :request do
  let(:user) { create(:user) }
  let(:order) { create(:order, user: user) }
  let!(:order_message) { create(:order_message, user: user, order: order) }

  before do
    allow_any_instance_of(Api::V1::OrderMessagesController).to receive(:current_user).and_return(user)
  end

  describe 'GET #index' do
    before do
      get "/api/v1/orders/#{order.id}/order_messages"
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'returns the order messages' do
      expect(json_response.length).to eq(1)
      expect(json_response.first['id']).to eq(order_message.id)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) { { order_message: { content: 'Test message' } } }

      before do
        post "/api/v1/orders/#{order.id}/order_messages", params: valid_params
      end

      it 'creates a new order message' do
        expect(OrderMessage.count).to eq(2)
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { order_message: { content: '' } } }

      before do
        post "/api/v1/orders/#{order.id}/order_messages", params: invalid_params
      end

      it 'does not create a new order message' do
        expect(OrderMessage.count).to eq(1)
      end

      it 'returns an error' do
        expect(response.body).to include('error')
      end
    end
  end
end
