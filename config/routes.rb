Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users
  resources :articles do
    resources :comments
  end

  resources :categories
  resources :tags

  delete ' /categories/:id/delete' => 'categories#delete', as: 'delete_category'
  get '/search' => 'search#index', as: :search

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :articles do
        resources :comments
      end
      resources :users
    end
  end
end
