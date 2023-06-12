Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#index'

  resources :services, only: [:index, :show] do
    collection do
      get :search
      post :make_search
      get :make_search
    end
    member do
      post :available_slots
    end
  end

  resources :service_providers, only: [:new, :create, :edit, :update] do
    resources :services
  end
end
