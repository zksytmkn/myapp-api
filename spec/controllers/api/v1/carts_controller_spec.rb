require 'rails_helper'

RSpec.describe Api::V1::CartsController, type: :controller do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:cart) { create(:cart, user: user, product: product) }

  before do
    allow_any_instance_of(UserAuthenticateService).to receive(:current_user).and_return(user)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Cart' do
        expect {
          post :create, params: { cart: attributes_for(:cart) }
        }.to change(Cart, :count).by(1)
      end

      it 'returns a 201 status code' do
        post :create, params: { cart: attributes_for(:cart) }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Cart' do
        expect {
          post :create, params: { cart: attributes_for(:cart, quantity: nil) }
        }.to change(Cart, :count).by(0)
      end

      it 'returns a 422 status code' do
        post :create, params: { cart: attributes_for(:cart, quantity: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid parameters' do
      let(:new_attributes) { { quantity: 2 } }

      it 'updates the requested cart' do
        put :update, params: { id: cart.to_param, cart: new_attributes }
        cart.reload
        expect(cart.quantity).to eq(new_attributes[:quantity])
      end

      it 'returns a 200 status code' do
        put :update, params: { id: cart.to_param, cart: new_attributes }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      it 'does not update the cart' do
        put :update, params: { id: cart.to_param, cart: { quantity: nil } }
        cart.reload
        expect(cart.quantity).not_to be_nil
      end

      it 'returns a 422 status code' do
        put :update, params: { id: cart.to_param, cart: { quantity: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested cart' do
      cart # create a cart
      expect {
        delete :destroy, params: { id: cart.to_param }
      }.to change(Cart, :count).by(-1)
    end

    it 'returns a 200 status code' do
      delete :destroy, params: { id: cart.to_param }
      expect(response).to have_http_status(:ok)
    end
  end
end
