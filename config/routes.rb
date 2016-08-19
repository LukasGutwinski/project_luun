Rails.application.routes.draw do
	devise_for :users,

	controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }


  resources :listings do
    collection do
      get :favorites
    end
    resources :favorites, only: [:create, :destroy]
    resources :requests do
      member do
        put :approve
        put :cancel_approval
      end
    end
  end

  root to: 'pages#home'

  mount Attachinary::Engine => "/attachinary"

  namespace :user do
    resources :requests, only: [:index]
    resources :listings, only: [:index] do
      resources :requests, :only => [:index]
    end
  end


  namespace :admin do
    resources :listings
    resources :users
  end

  match 'admin/users/:id' => 'admin/users#destroy', :via => :delete, :as => :admin_destroy_user

end
