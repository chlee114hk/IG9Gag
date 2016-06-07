Rails.application.routes.draw do
  root to: "home#index"

  # API
  resources :users, only: [:show] do
      member do
        get :medias
      end
  end

  get '*path' => 'home#index'
end
