Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :events do
    resources :polls do
      resources :fields
    end
    resources :guests
    resources :expenses, except: [:edit, :update] do
      resources :transactions, only: [:new, :create, :destroy]
    end
  end
end
