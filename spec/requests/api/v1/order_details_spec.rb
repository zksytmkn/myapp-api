require 'rails_helper'

RSpec.describe "Api::V1::OrderDetails", type: :request do
  let!(:order_detail) { create(:order_detail) }
  let(:valid_params) { { order_detail: { status: 'shipped' } } } # Moved this line
  let(:headers) { { 'X-Requested-With': 'XMLHttpRequest' } }

  describe 'PATCH #update' do
    context 'with valid parameters' do
      it 'updates the order detail' do
        patch "/api/v1/order_details/#{order_detail.id}", params: valid_params, headers: headers
        expect(order_detail.reload.status).to eq('shipped')
      end

      it 'returns a successful response' do
        patch "/api/v1/order_details/#{order_detail.id}", params: valid_params, headers: headers
        expect(response).to be_successful
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { order_detail: { status: nil } } }

      it 'does not update the order detail' do
        patch "/api/v1/order_details/#{order_detail.id}", params: invalid_params, headers: headers
        expect(order_detail.reload.status).to_not be_nil
      end

      it 'returns an error' do
        patch "/api/v1/order_details/#{order_detail.id}", params: invalid_params, headers: headers
        expect(response.body).to include('error')
      end
    end

    context 'with non-existent order detail id' do
      it 'returns a not found error' do
        patch "/api/v1/order_details/9999999", params: valid_params, headers: headers
        expect(response.body).to include('注文詳細が見つかりません')
      end
    end
  ecd nd
end