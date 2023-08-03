Rails.application.routes.draw do
  get 'welcome/index'
  root to: 'welcome#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


  resources :foods, only: [:index, :show, :destroy, :new, :create]
  # resources :recipes, only: [:index, :show, :new, :create, :destroy]
  resources :recipes, only: [:index, :show, :new, :create, :destroy] do
    member do
      patch :toggle_public
    end
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
end