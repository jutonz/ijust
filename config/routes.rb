Rails.application.routes.draw do
  resources :things do
    resources :occurrences
  end

  root 'things#new'
  get 'search', to: 'things#search'

  mount Ijust::API => '/'
end
