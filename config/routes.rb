Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # auth_token
      resources :auth_token, only: [:create] do
        post :refresh, on: :collection
        delete :destroy, on: :collection
      end

      # guests
      resources :guest_sessions

      # users
      resources :users do
        get :confirm_email, on: :collection
      end

      # products
      resources :products

      # productComments
      resources :product_comments

      # productFavorites
      resources :product_favorites
      resource :product_favorites

      # productUnfavorites
      resources :product_unfavorites
      resource :product_unfavorites

      # carts
      resources :carts
      resource :carts

      # orders
      resources :orders

      # orderDetails
      resources :order_details

      # posts
      resources :posts

      # postComments
      resources :post_comments

      # postFavorites
      resources :post_favorites
      resource :post_favorites

      # postUnfavorites
      resources :post_unfavorites
      resource :post_unfavorites

      # communities
      resources :communities

      # communityMessages
      resources :community_messages

      # participations
      resources :participations
      resource :participations

      # invitations
      resources :invitations

      # relationships
      resources :relationships
      resource :relationships
    end
  end
end