Rails.application.routes.draw do
  resources :books
  get 'faculty/show'
  get 'student/show'
  #get 'admin/show'
  resources :admin, only: [:show]
  resources :student, only: [:show]
  resources :faculty, only: [:show]
  resources :sessions, only: [:new, :create, :destroy]  
  get 'user_signup', to: 'users#new', as: 'signup'
  post 'user_signup', to: 'users#create', as: 'signup_post'   
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create', as: 'login_post'   
  get 'logout', to: 'sessions#destroy', as: 'logout'  
  resources :admins
  resources :users
  get 'welcome/index'
  root 'welcome#index'
end
