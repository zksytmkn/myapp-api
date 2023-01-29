Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # auth_token
      resources :auth_token, only:[:create] do
        post :refresh, on: :collection
        delete :destroy, on: :collection
      end

      # products
      resources :products, only:[:index, :show, :new, :create, :edit, :update, :destroy]

      # posts
      resources :posts, only:[:index]

      # communities
      resources :communities, only:[:index]
    end
  end
end