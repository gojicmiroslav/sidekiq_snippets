require 'sidekiq/web'

Rails.application.routes.draw do
  resources :snippets
  root to: "snippets#new"

  mount Sidekiq::Web, at: '/sidekiq'
end
