Rails.application.routes.draw do
	devise_for :users,

	controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }

  get "json", to: "pages#json", :defaults => { :format => 'json' }

  resources :listings

  resources :listings, :only => [:index, :show] do
    resources :requests do
      member do
        put :approve
        put :cancel_approval
      end
    end
    resources :favorites do
      collection do
        put :favorite
        put :unfavorite
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
