Rails.application.routes.draw do
  get 'welcome/index'
  root to: 'welcome#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


  resources :recipes, expect: [:update]
  resources :foods, only: [:index, :show, :destroy, :new, :create]

  resources :recipe_foods, only: [:edit, :create, :update, :destroy, :new]

  resources :recipes, only: [:index, :show, :new, :create, :destroy] do
    member do
      patch :toggle_public
    end
  end
  get '/public_recipes', to: 'recipes#public_recipes'
  get '/shopping_list', to: 'shopping_list#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
end
