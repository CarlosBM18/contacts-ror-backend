Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :contacts
      resources :users, only: [:create, :destroy, :update]
      post "/login", to: "users#login"
      resources :contacts_history, only: [:show]
    end
  end
end
