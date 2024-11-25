Rails.application.routes.draw do
  get 'locations/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  locales = I18n.available_locales.join('|')
  scope '(:locale)', locale: /#{locales}/ do
    devise_for :users

    root to: 'pages#map'

    authenticated do
      root to: 'pages#map', as: :authenticated_root
    end

    get '/map', to: 'pages#map'
    get '/moon', to: 'pages#moon'
    get '/sun', to: 'pages#sun'

    resources :posts, except: %i[new update] do
      resources :wizard, only: %i[show update],
                         controller: 'posts/wizard'
      resource :fetch_image, only: %i[show],
                             controller: 'posts/fetch_image'
    end
    resources :locations, only: %i[index]
    resources :spaces do
      resources :users, only: %i[create], controller: 'spaces/users'
    end
    resources :links, only: %i[show create destroy], param: :sku
    resources :users, only: %i[index edit update destroy]
    post '/open-modal', to: 'pages#open_modal', as: 'open_modal'
  end
end
