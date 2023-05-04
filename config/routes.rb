Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :auth_token, only: [:create] do
        collection do
          post :refresh
          delete :destroy
        end
      end

      resources :guest_sessions, only: [:create]
      resources :contacts, only: [:create]

      #users
      resources :users , only: [:index, :create, :show, :update, :destroy] do
        collection do
          post :send_email_reset_confirmation
          post :send_password_reset_email
          post :forgot_password
          patch :update_password
          get :confirm_email
          get :confirm_email_reset
          put :reset_password
        end
      end

      resources :relationships, only: [:create, :destroy] do
        get :user_follow_relationships, on: :member
      end

      resources :password_resets, only: [:update] do
        get :reset_password_confirmation, on: :collection
      end

      #products
      resources :products, only: [:index, :create, :show, :update, :destroy] do
        resources :product_comments, only: [:index, :create, :destroy]
      end

      resources :product_favorites, only: [:index, :create, :show, :update] do
        delete :destroy, on: :collection, path: ':product_id/user/:user_id'
      end

      resources :product_unfavorites, only: [:index, :create, :show, :update] do
        delete :destroy, on: :collection, path: ':product_id/user/:user_id'
      end

      #carts
      resources :carts, only: [:index, :create, :update, :destroy]

      #orders
      resources :orders, only: [:index, :create, :show, :update] do
        resources :order_messages, only: [:index, :create]
      end

      #posts
      resources :posts, only: [:index, :create, :show, :update, :destroy] do
        resources :post_comments, only: [:index, :create, :destroy]
      end

      resources :post_favorites, only: [:index, :create, :show, :update] do
        delete :destroy, on: :collection, path: ':post_id/user/:user_id'
      end

      resources :post_unfavorites, only: [:index, :create, :show, :update] do
        delete :destroy, on: :collection, path: ':post_id/user/:user_id'
      end

      #communities
      resources :communities, only: [:index, :create, :show, :update, :destroy] do
        resources :community_messages, only: [:index, :create]
      end

      resources :invitations, only: [:index, :create, :destroy]
      resources :participations, only: [:index, :create, :destroy] do
        delete :destroy, on: :collection, path: ':community_id/user/:user_id'
      end
    end
  end
end
