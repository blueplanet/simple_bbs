SimpleBbs::Application.routes.draw do
  devise_for :users

  resources :users, only: [:show]
  resources :topics, only: [:index, :show, :new, :create, :edit, :update]
  resources :nodes, only: [:show]

  root to: "topics#index"

  get "ui/:action" => "ui"
end
