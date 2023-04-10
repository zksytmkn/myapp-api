Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :auth_token, only: [:create] do
        collection do
          post :refresh
          delete :destroy
        end
      end

      resources :guest_sessions
      resources :contacts, only: [:create]

      resources :users , only: [:index, :create, :show, :update, :destroy] do
        collection do
          post :send_email_reset_confirmation
          post :send_password_reset_email
          post :forgot_password
          patch :update_password
          get :confirm_email_reset
          put :reset_password
        end
      end

      resources :password_resets do
        get :reset_password_confirmation, on: :collection
      end

      resources :products
      resources :product_comments

      resources :product_favorites, only: [:index, :create, :show, :update] do
        delete :destroy, on: :collection, path: ':product_id/user/:user_id'
      end

      resources :product_unfavorites, only: [:index, :create, :show, :update] do
        delete :destroy, on: :collection, path: ':product_id/user/:user_id'
      end

      resources :carts

      resources :orders
      resources :order_details

      resources :posts
      resources :post_comments

      resources :post_favorites, only: [:index, :create, :show, :update] do
        delete :destroy, on: :collection, path: ':post_id/user/:user_id'
      end

      resources :post_unfavorites, only: [:index, :create, :show, :update] do
        delete :destroy, on: :collection, path: ':post_id/user/:user_id'
      end

      resources :communities
      resources :community_messages
      resources :participations
      resources :invitations
      resources :relationships
    end
  end
end
