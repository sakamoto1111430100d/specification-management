Rails.application.routes.draw do
  devise_for :users
  root 'searches#index'
  resources :users, only: [:edit, :update]
  resources :companies, only: :index
  resource :companies, only: [:edit, :update]
  resources :items, only: :index
  resources :searches, only: [:index, :new, :create] do
    collection do
      get 'search'
    end
  end
end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
