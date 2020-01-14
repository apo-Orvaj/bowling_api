Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :games, only: [:show]

  post 'new_game' => 'games#create'

  post '/roll' => 'games#roll' #{pins: 3, game_id: 1}

  get 'game_status/:id' => 'games#game_status'
end
