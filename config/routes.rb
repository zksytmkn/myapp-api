Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :auth_token, only: [:create] do
        post :refresh, on: :collection
        delete :destroy, on: :collection
      end

      resources :guest_sessions
      resources :contacts, only: [:create]

      resources :users , only: [:index, :create, :show, :update, :destroy] do
        post :send_email_reset_confirmation, on: :collection
        post :send_password_reset_email, on: :collection
        post :forgot_password, on: :collection
        patch :update_password, on: :collection
        get :confirm_email_reset, on: :collection
        put :reset_password, on: :collection
      end

      resources :password_resets do
        get :reset_password_confirmation, on: :collection
      end

      resources :products
      resources :product_comments
      resources :product_favorites
      resources :product_unfavorites

      resources :carts

      resources :orders
      resources :order_details

      resources :posts
      resources :post_comments
      resources :post_favorites
      resources :post_unfavorites

      resources :communities
      resources :community_messages
      resources :participations
      resources :invitations
      resources :relationships
    end
  end
end
