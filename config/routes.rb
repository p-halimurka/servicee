Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#index'

  resources :users, only: [:show] do
  end

  resources :service_providers, only: [:new, :create, :edit, :update] do
    resources :services
  end
end
