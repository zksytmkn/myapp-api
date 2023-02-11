Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # auth_token
      resources :auth_token, only:[:create] do
        post :refresh, on: :collection
        delete :destroy, on: :collection
      end

      # users
      resources :users

      # products
      resources :products

      # productComments
      resources :product_comments

      # posts
      resources :posts

      # postComments
      resources :post_comments

      # communities
      resources :communities
    end
  end
end