Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'
  resources :events do
    resources :polls
    resources :guests
    resources :expenses, except: [:show]
  end
end
