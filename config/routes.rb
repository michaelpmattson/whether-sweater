Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :activities,  only: :index
      resources :backgrounds, only: :index
      resources :forecast,    only: :index
      resources :road_trip,   only: :create
      resources :sessions,    only: :create
      resources :users,       only: :create
    end
  end
end
