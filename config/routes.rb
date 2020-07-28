Rails.application.routes.draw do
  devise_for :users
  root 'searches#index'

  resources :individuals, only: [:new, :create, :edit, :index] do
    collection do
      get 'edit_form'
    end
    resources :companies, only: [:index, :edit, :update] do
      collection do
        get 'edit_form'
      end
    end
    resources :items, only: [:index]
    resource :documents, only: [:show]
    resources :documents, only: [:destroy, :edit, :update, :new, :create] do
      collection do
        get 'edit_form'
      end
    end
    resources :searches, only: [:index, :new, :create] do
      collection do
        get 'search', 'menue_list'
      end
    end
  end
  resource :sessions, only: [:new, :destroy]  do
    collection do
      get 'select'
    end
  end
  resource :stocks, only: [:create, :destroy]
end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
