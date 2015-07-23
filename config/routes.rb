Rails.application.routes.draw do
  current_api_routes = lambda do
    resources :clients, only: [] do
      resources :tokens, only: [:create]
    end
  end

  scope module: "apress", constraints: {domain: :current} do
    namespace :api do
      scope module: :v1, &current_api_routes
      namespace :v1, &current_api_routes
      resource :deprecated_version, only: :show
    end
  end
end
