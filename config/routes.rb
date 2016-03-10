Rails.application.routes.draw do
  scope module: "apress", constraints: {domain: :current} do
    api_namespace(versions: :v1) do
      resources :clients, only: [] do
        resources :tokens, only: [:create]
      end
    end

    namespace :api do
      resource :deprecated_version, only: :show
    end
  end
end
