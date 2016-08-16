Rails.application.routes.draw do
	devise_for :users,
	controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
	resources :listings, :only => [:index, :show] do
		resources :requests, :except => [:index]
	end
	root to: 'pages#home'
	resources :listings
  mount Attachinary::Engine => "/attachinary"
  namespace :user do
    resources :requests, only: [:index]
  end
