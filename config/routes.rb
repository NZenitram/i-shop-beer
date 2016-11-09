Rails.application.routes.draw do

  resources :styles, only: [:index]
  resources :beers, only: [:index, :show]

  resources :styles, only: [:index], param: :slug do
    resources :beers, only: [:index]
  end

  resources :users, only: [:new, :create] do
    resources :orders, only: [:create, :show]
  end

  get '/orders', to: 'orders#index'

  get '/dashboard', to: 'dashboard#show'

  resources :cart, only: [:create]

  delete '/cart/remove', path: 'destroy/:id'
  post '/cart/update', path: 'update'
  get '/cart' => 'cart#show'

  get '/items' => 'beers#index'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  root to: 'sessions#new'

  namespace :admin do
    get '/dashboard', to: 'dashboard#show'
    post '/dashboard/paid', to: 'dashboard#paid', as: 'order_paid'
    post '/dashboard/cancel', to: 'dashboard#cancel', as: 'order_cancel'
    post '/dashboard/complete', to: 'dashboard#complete', as: 'order_complete'

    resources :users, only: [:edit, :update]
    resources :beers, only: [:index, :edit, :update]
  end
  
  get '/:slug' => 'styles#show'

end
