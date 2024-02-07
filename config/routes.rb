Rails.application.routes.draw do
  # pages can manage the users model
  resources :pages do 
    resources :users
  end
  
  get '/signup', to: 'users#new', as: 'signup'

  resources :bookings
  resources :rooms

  # this route allow the user to create a new booking in the booking controoler
  get "bookings/:room/new", to: "bookings#new_booking", as: "new_room_booking"

  root 'pages#index'

  resources :user_sessions, only: [:new, :create, :destroy]
  resources :users, only: [:index, :new, :create]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

end
