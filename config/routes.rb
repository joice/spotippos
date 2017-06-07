Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  apipie
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :properties
    end
  end
end
