Rails.application.routes.draw do
  apipie
  namespace :api do
    namespace :v1 do
      resources :properties
    end
  end
end
