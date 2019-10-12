Rails.application.routes.draw do
 	resources :books
 	get 'faculty/show'
	get 'student/show'
 	get 'admin/search'
 	get 'admin/issue'
 	get 'admin/issueBook'
 	post 'admin/issueBook'
	get 'admin/searchResult'
	get 'admin/indexBookIssue'
	post 'admin/returnBook'
	get 'admin/return'

	post 'admin/searchResult'
   	#get 'admin/issuetrue'
	post 'admin/issuetrue'

	get 'student/search'
	get 'student/searchResult'
	post 'student/searchResult'
	get 'student/indexBookIssue'

	get 'faculty/search'
	get 'faculty/searchResult'
	post 'faculty/searchResult'
	get 'faculty/indexBookIssue'

	get '/returnBook/:id', to: 'admin#performReturn'
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
	get 'change_password', to: 'change_password#changePassword'   
	post 'change_password', to: 'change_password#updatePassword'
	resources :admins
	resources :users
	get 'welcome/index'
	root 'welcome#index'
end
