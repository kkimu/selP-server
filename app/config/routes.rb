Rails.application.routes.draw do
  get 'jidoris/index'

  get 'jidoris/new'

  get 'campaigns/index'

  get 'campaigns/new'

  resources :users
  resources :campaigns
  resources :jidoris
  post 'users/:user_id/jidoris', to: 'users#share_jidori'
  get 'users/:id/points', to: 'users#show_points'
  get 'users/:id/history', to: 'users#show_history'
end