Rails.application.routes.draw do
  apipie
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :properties
    end
  end
end
