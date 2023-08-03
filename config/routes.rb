Rails.application.routes.draw do
  get 'welcome/index'
  root to: 'welcome#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :recipes, only: [:index, :show]

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  get '/public_recipies', to: 'recipies#public_recipies'
  root "recipes#public_recipies"
end

