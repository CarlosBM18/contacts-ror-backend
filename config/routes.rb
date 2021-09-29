Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :contacts
      resources :users, only: [:create, :destroy, :update]
      post "/login", to: "users#login"
      resources :contact_histories, only: [:show]
    end
  end
end
