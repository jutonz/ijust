Rails.application.routes.draw do
  resources :things

  root 'things#new'
  get 'search', to: 'things#search'
end
