Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :backgrounds, only: :index
      resources :forecast,    only: :index
      resources :users,       only: :create
    end
  end
end
