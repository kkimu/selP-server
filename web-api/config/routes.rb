Rails.application.routes.draw do
  resources :users
  resources :campaigns
  resources :jidoris

  post 'users/:user_id/jidoris', to: 'jidoris#create'
  get 'users/:id/points', to: 'users#show_points'
  get 'users/:id/history', to: 'users#show_history'
end
