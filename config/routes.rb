Rails.application.routes.draw do
  mount_devise_token_auth_for 'Renter', at: 'renter'

  mount_devise_token_auth_for 'Agent', at: 'agent'
  as :agent do
    # Define routes for Agent within this block.
  end
  get '/agents/signup', to: 'agents#signup'
  get '/agents/login', to: 'agents#login'
  get '/agents/secret', to: 'agents#secret'

  get '/renters/signup', to: 'renters#signup'
  get '/renters/login', to: 'renters#login'
  get '/renters/secret', to: 'renters#secret'

  namespace :api do
    resources :chats, only: [:new, :create, :show, :index]
    resources :agents
    resources :agent_ratings
    resources :renter_ratings
    resources :apartments
    resources :property_listings
  end

  # get '/secret', to: 'statics#secret'
  # get '/agents', to: 'statics#agents'
  # get '/renters', to: 'statics#renters'
end
