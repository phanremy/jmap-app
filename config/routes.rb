Rails.application.routes.draw do
  get 'locations/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  locales = I18n.available_locales.join('|')
  scope '(:locale)', locale: /#{locales}/ do
    devise_for :users

    authenticated :user, lambda {|u| u.admin? } do
      root to: 'users#index', as: :admin_root
    end

    authenticated do
      root to: 'spaces#index', as: :authenticated_root
    end

    root 'pages#front'
    get '/front', to: 'pages#front'
    get '/map', to: 'pages#map'
    get '/moon', to: 'pages#moon'
    get '/sun', to: 'pages#sun'

    resources :posts
    resources :locations, only: %i[index]
    resources :spaces do
      resources :users, only: %i[create], controller: 'spaces/users'
    end
    resources :links, only: %i[show create destroy], param: :sku
    resources :users, only: %i[index edit update destroy]
    post '/open-modal', to: 'pages#open_modal', as: 'open_modal'
  end
end
