Rails.application.routes.draw do
  devise_for :users
  root 'searches#index'
  resources :companies, only: [:index, :edit, :update] do
    collection do
      get 'edit_form'
    end
  end
  resources :items, only: [:index]
  resources :documents, only: [:destroy, :edit, :update, :new, :create] do
    collection do
      get 'edit_form'
    end
  end
  resource :documents, only: [:show]
  resources :searches, only: [:index, :new, :create] do
    collection do
      get 'search'
    end
  end
end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
