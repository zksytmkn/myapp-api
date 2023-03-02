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
      resources :users

      # products
      resources :products

      # productComments
      resources :product_comments

      # productFavorites
      resources :product_favorites

      # productUnfavorites
      resources :product_unfavorites

      # posts
      resources :posts

      # postComments
      resources :post_comments

      # postFavorites
      resources :post_favorites

      # postUnfavorites
      resources :post_unfavorites

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