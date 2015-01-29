Rails.application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  resources :articles do
    resources :comments
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :articles
      resources :users
    end
  end
end