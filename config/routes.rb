Rails.application.routes.draw do
  mount_devise_token_auth_for 'Renter', at: 'renter', controllers: {
    sessions: 'overrides/sessions',
    registrations: 'overrides/registrations'
  }

  mount_devise_token_auth_for 'Agent', at: 'agent', controllers: {
    sessions: 'overrides/sessions',
    registrations: 'overrides/registrations'
  }
  mount ActionCable.server => '/cable'

  as :agent do
    # Define routes for Agent within this block.
  end
  get '/home', to: 'statics#home'
  get '/agents/signup', to: 'agents#signup'
  get '/agents/login', to: 'agents#login'
  get '/agents/secret', to: 'agents#secret'

  get '/renters/signup', to: 'renters#signup'
  get '/renters/login', to: 'renters#login'
  get '/renters/secret', to: 'renters#secret'

  namespace :api do
    resources :chats, only: [:new, :create, :show, :index]
    get '/userinfo', to: 'chats#userinfo'
    get '/chats/findChat/:id/:enquiryId', to: 'chats#findChat'
    resources :agents
    resources :renters

    resources :agent_ratings
    resources :renter_ratings
    get '/userinfos', to: 'userinfos#userinfo'

    resources :apartments
    get '/apartments/enquiry/:id', to: 'apartments#enquiry'
    resources :apartment_pictures
    resources :enquiries
    resources :enquiry_agents, only: [:index, :show]
    resources :property_listings
    resources :appointments
    put '/appointments/confirm/:id', to: 'appointments#confirm'
  end

  # get '/secret', to: 'statics#secret'
  # get '/agents', to: 'statics#agents'
  # get '/renters', to: 'statics#renters'
  get '/apartments', to: 'statics#createApt'

end
