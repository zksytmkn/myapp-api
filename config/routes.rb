Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :auth_token, only: %i[create] do
        collection do
          post :refresh
          delete :destroy
        end
      end

      #users
      resources :users, only: %i[index show create update destroy] do
        collection do
          get :confirm_email
          get :confirm_email_reset
          post :send_email_reset_confirmation
          post :send_password_reset_email
          post :forgot_password
          patch :update_password
          put :reset_password
        end
      end

      #guest_users
      resources :guest_sessions, only: %i[create]

      #follows
      resources :relationships, only: %i[create destroy] do
        get :user_follow_relationships, on: :member
      end

      #contacts
      resources :contacts, only: %i[create]

      #products
      resources :products, only: %i[index show create update destroy] do
        resources :product_comments, only: %i[index create destroy]
      end
      resources :product_favorites, only: %i[index create] do
        delete 'user', on: :member, to: 'product_favorites#destroy'
      end
      resources :product_unfavorites, only: %i[index create] do
        delete 'user', on: :member, to: 'product_unfavorites#destroy'
      end

      #carts
      resources :carts, only: %i[index create update destroy]

      #orders
      resources :orders, only: %i[index show create] do
        resources :order_messages, only: %i[index create]
      end

      #order_details
      resources :order_details, only: %i[update] do
      end

      #posts
      resources :posts, only: %i[index show create update destroy] do
        resources :post_comments, only: %i[index create destroy]
      end
      resources :post_favorites, only: %i[index create] do
        delete 'user', on: :member, to: 'post_favorites#destroy'
      end
      resources :post_unfavorites, only: %i[index create] do
        delete 'user', on: :member, to: 'post_unfavorites#destroy'
      end

      #communities
      resources :communities, only: %i[index show create update destroy] do
        resources :community_messages, only: %i[index create]
      end
      resources :invitations, only: %i[index create]
      resources :participations, only: %i[index create] do
        delete :destroy, on: :member
      end
    end
  end
end
