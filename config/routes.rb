Rails.application.routes.draw do
  get 'welcome/index'
  root to: 'welcome#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Wrap Devise routes inside a devise_scope block
  # devise_scope :user do
  #   get '/users/sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  # end


  resources :recipes, only: [:index, :show]

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
end

