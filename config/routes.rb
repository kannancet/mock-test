Rails.application.routes.draw do

  root to: 'visitors#index'
  devise_for :users
  
  get 'users/list'
  get 'messages/list'

  namespace :api do
    resources :messages, :users, except: [:new, :edit]
  end

  # namespace path_helper hackery!
  get '/api/messages/:id', to: 'messages#show', as: :message
  get '/api/users/:id', to: 'users#show', as: :user

  # Added by Koudoku.
  mount Koudoku::Engine, at: 'koudoku'
  scope module: 'koudoku' do
    get 'pricing' => 'subscriptions#index', as: 'pricing'
  end

end


