Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # auth_token
      resources :auth_token, only:[:create] do
        post :refresh, on: :collection
        delete :destroy, on: :collection
      end

      # projects
      resource :projects, only:[:index]
    end
  end
end
