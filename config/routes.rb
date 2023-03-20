Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # auth_token
      resources :auth_token, only: [:create] do
        post :refresh, on: :collection
        delete :destroy, on: :collection
      end

      # guests
      resources :guest_sessions, only: [:create]

      # users
      resources :users do
        get :confirm_email, on: :collection
      end

      # products
      resources :products

      # productComments
      resources :product_comments

      # productFavorites
      resources :product_favorites, :only => [:index, :show]
      resource :product_favorites, :only => [:create, :destroy]

      # productUnfavorites
      resources :product_unfavorites, :only => [:index, :show]
      resource :product_unfavorites, :only => [:create, :destroy]

      # carts
      resources :carts, :only => [:show, :update, :destroy]
      resource :carts, :only => :create

      # orders
      resources :orders

      # orderDetails
      resources :order_details

      # posts
      resources :posts

      # postComments
      resources :post_comments

      # postFavorites
      resources :post_favorites, :only => [:index, :show]
      resource :post_favorites, :only => [:create, :destroy]

      # postUnfavorites
      resources :post_unfavorites, :only => [:index, :show]
      resource :post_unfavorites, :only => [:create, :destroy]

      # communities
      resources :communities

      # communityMessages
      resources :community_messages

      # participations
      resources :participations, :only => :show
      resource :participations, :only => [:create, :destroy]

      # invitations
      resources :invitations

      # relationships
      resources :relationships, :only => :show
      resource :relationships, :only => [:create, :destroy]
    end
  end
end