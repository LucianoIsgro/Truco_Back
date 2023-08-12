Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"


  delete '/logout', to: 'logins#destroy'

  get '/current_player', to: 'players#me' 

  resources :logins, only: [:create]
 
  resources :signups, only:[:create]
  
  resources :players do 
    get '/cards', to: 'players#cards'
    put '/irse', to: 'players#irse'
  end
  
  resources :cards do 
    delete 'player_card', to: 'player_cards#delete_player_card'
  
  end

  resources :games do
    get '/players', to: 'games#players'  
    post '/deal', to: 'games#deal'
    delete '/delete', to: 'player_games#delete_player_game'
    post 'player_cards/:id', to:'player_cards#create'
  end
  
  resources :player_games

  resources :player_cards 
  
  
  
  

end
